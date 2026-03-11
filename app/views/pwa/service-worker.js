// Minimal service worker for PWA installability.
// Phase 2 will add caching strategies for offline support.
self.addEventListener("install", (event) => {
  self.skipWaiting()
})

self.addEventListener("activate", (event) => {
  event.waitUntil(clients.claim())
})
