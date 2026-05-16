(function () {
  const script = document.currentScript;
  const versionUrl = script && script.dataset ? script.dataset.versionUrl : "";
  const storageKey = "diymagic-site-version";
  const reloadKey = "diymagic-site-version-reload";

  if (!versionUrl || !window.localStorage || !window.sessionStorage) {
    return;
  }

  function readStoredVersion() {
    try {
      return window.localStorage.getItem(storageKey);
    } catch (error) {
      return "";
    }
  }

  function writeStoredVersion(version) {
    try {
      window.localStorage.setItem(storageKey, version);
    } catch (error) {
      return;
    }
  }

  function reloadOnce(version) {
    const reloadMarker = `${reloadKey}:${version}`;

    if (window.sessionStorage.getItem(reloadKey) === reloadMarker) {
      return;
    }

    window.sessionStorage.setItem(reloadKey, reloadMarker);
    window.location.reload();
  }

  function checkVersion() {
    const requestUrl = `${versionUrl}${versionUrl.includes("?") ? "&" : "?"}t=${Date.now()}`;

    fetch(requestUrl, { cache: "no-store", credentials: "same-origin" })
      .then((response) => {
        if (!response.ok) {
          throw new Error("Versionsdatei konnte nicht geladen werden.");
        }
        return response.json();
      })
      .then((data) => {
        const version = data && data.version ? String(data.version) : "";
        const storedVersion = readStoredVersion();

        if (!version) {
          return;
        }

        if (!storedVersion) {
          writeStoredVersion(version);
          return;
        }

        if (storedVersion !== version) {
          writeStoredVersion(version);
          reloadOnce(version);
        }
      })
      .catch(() => {});
  }

  checkVersion();

  document.addEventListener("visibilitychange", function () {
    if (!document.hidden) {
      checkVersion();
    }
  });
})();
