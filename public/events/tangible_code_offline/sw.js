// オフラインで動かすための Service Worker。
// 初回アクセス時に ruby.wasm と p5.js を含む一式をキャッシュへ入れる。
const CACHE = "tangible-code-offline-v2";

const ASSETS = [
  "./",
  "./index.html",
  "./manifest.webmanifest",
  "./vendor/browser.script.iife.js",
  "./vendor/p5.js",
  "./vendor/p5.rb",
  "./vendor/ruby+stdlib.wasm",
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches
      .open(CACHE)
      .then((cache) => cache.addAll(ASSETS))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(keys.filter((key) => key !== CACHE).map((key) => caches.delete(key)))
      )
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (event) => {
  const request = event.request;
  if (request.method !== "GET") return;

  // HTML はネットワークを優先する。
  // キャッシュ優先にすると、更新した index.html が永久に届かなくなる。
  if (request.mode === "navigate" || request.destination === "document") {
    event.respondWith(
      fetch(request)
        .then((response) => {
          const copy = response.clone();
          caches.open(CACHE).then((cache) => cache.put(request, copy));
          return response;
        })
        .catch(() => caches.match(request, { ignoreSearch: true }))
    );
    return;
  }

  // wasm と p5.js は中身が変わらないのでキャッシュ優先。
  event.respondWith(
    caches
      .match(request, { ignoreSearch: true })
      .then((cached) => cached || fetch(request))
  );
});
