const CACHE_VERSION = "v1"
const STATIC_CACHE = `static-${CACHE_VERSION}`
const PAGES_CACHE = `pages-${CACHE_VERSION}`

const PRECACHE_URLS = [
  "/",
  "/icon.png",
  "/icon.svg"
]

// Install: precache app shell
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(STATIC_CACHE).then((cache) => cache.addAll(PRECACHE_URLS))
  )
  self.skipWaiting()
})

// Activate: clean up old caches
self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((key) => key !== STATIC_CACHE && key !== PAGES_CACHE)
          .map((key) => caches.delete(key))
      )
    )
  )
  self.clients.claim()
})

self.addEventListener("fetch", (event) => {
  const { request } = event
  const url = new URL(request.url)

  // Only handle same-origin GET requests
  if (request.method !== "GET" || url.origin !== self.location.origin) return

  // Skip Turbo Stream requests — let them go to the network
  if (request.headers.get("Accept")?.includes("text/vnd.turbo-stream.html")) return

  // Static assets (JS, CSS, images, fonts): cache-first
  if (isStaticAsset(url.pathname)) {
    event.respondWith(cacheFirst(request, STATIC_CACHE))
    return
  }

  // HTML pages: network-first, fall back to cache
  if (request.headers.get("Accept")?.includes("text/html")) {
    event.respondWith(networkFirst(request, PAGES_CACHE))
    return
  }
})

function isStaticAsset(pathname) {
  return /\.(js|css|png|jpg|jpeg|gif|svg|ico|woff2?|ttf|eot)(\?|$)/.test(pathname) ||
    pathname.startsWith("/assets/")
}

// Serve from cache, fall back to network and update cache
async function cacheFirst(request, cacheName) {
  const cached = await caches.match(request)
  if (cached) return cached

  try {
    const response = await fetch(request)
    if (response.ok) {
      const cache = await caches.open(cacheName)
      cache.put(request, response.clone())
    }
    return response
  } catch {
    return new Response("", { status: 503 })
  }
}

// Try network first, fall back to cache if offline
async function networkFirst(request, cacheName) {
  try {
    const response = await fetch(request)
    if (response.ok) {
      const cache = await caches.open(cacheName)
      cache.put(request, response.clone())
    }
    return response
  } catch {
    const cached = await caches.match(request)
    if (cached) return cached

    return new Response(offlinePage(), {
      status: 503,
      headers: { "Content-Type": "text/html" }
    })
  }
}

function offlinePage() {
  return `<!DOCTYPE html>
<html data-theme="emerald" lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Offline - MCA Race Results</title>
  <style>
    body { font-family: system-ui, sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; background: #f5f5f5; color: #333; }
    .container { text-align: center; padding: 2rem; }
    h1 { font-size: 1.5rem; margin-bottom: 0.5rem; }
    p { color: #666; }
    button { margin-top: 1rem; padding: 0.5rem 1.5rem; background: #66cc8a; color: #fff; border: none; border-radius: 0.5rem; font-size: 1rem; cursor: pointer; }
  </style>
</head>
<body>
  <div class="container">
    <h1>You're offline</h1>
    <p>Previously visited pages are available offline. This page hasn't been cached yet.</p>
    <button onclick="window.location.reload()">Try again</button>
  </div>
</body>
</html>`
}
