// ==UserScript==
// @name         Tornicorn4
// @namespace    sullenTornicorn4
// @version      0.3
// @description  Automatically calculate the difficulty of attacking a target
// @author       sullengenie [1946152]
// @match        *://*.torn.com/profiles.php?XID=*
// @connect      railsicorn.herokuapp.com
// @grant        GM_getValue
// @grant        GM_setValue
// @grant        GM_deleteValue
// @grant        GM_addStyle
// ==/UserScript==



(function() {
  'use strict';

  const host = "https://railsicorn.herokuapp.com/";
  const playerId = parseInt(window.location.href.match(/XID=(\d+)/)[1]);
  let apiKey;
  let apiKeyInputCreated;

  const createHtml = (html) => document.createRange().createContextualFragment(html);
  const insertBefore = (nodes, target) => target.parentNode.insertBefore(nodes, target);
  const insertAfter  = (nodes, target) => target.parentNode.insertBefore(nodes, target.nextSibling);

  const apiKeyInputStyle = (style) => `#sullen-api-key-container { display: ${style.hidden ? 'none' : 'block'}; }`;

  const apiInputContainer = createHtml(`
<div class="profile-wrapper m-top10" id="sullen-api-key-container">
<div>
<div class="title-black top-round">Tornicorn - Input API Key</div>
<div class="cont bottom-round">
<div class="profile-container basic-info bottom-round">
<div style="padding: 10px">
<label>API Key:</label><input type="text" id="sullen-api-key-input"></input>
<div class="btn-wrap silver vinkuun-button">
<div class="btn" id="sullen-api-key-button">SUBMIT
</div></div></div></div></div></div></div>`);

  function topProfileContainer() {
    let userInfoContainer = document.querySelector('div.user-information');
    if (userInfoContainer !== undefined) {
      return userInfoContainer.parentNode.parentNode;
    }
    throw 'Cannot get the top profile container before the page loads';
  }

  function createApiKeyInput() {
    return waitForPageLoad()
      .then(() => {
        insertBefore(apiInputContainer, topProfileContainer());
        document.getElementById('sullen-api-key-button').onclick = submitApiKey;
        // console.log('Created api key input');
      });
  }

  function showApiKeyInput() {
    document.getElementById('api-key-container-style').innerText = apiKeyInputStyle({hidden: false});
  }

  function hideApiKeyInput() {
    // console.log('Hide api key input');
    document.getElementById('api-key-container-style').innerText = apiKeyInputStyle({hidden: true});
    removeApiKeyWarning();
  }

  function addApiKeyWarning() {
    apiKeyInputCreated.then(() =>
                            insertBefore(createHtml(`<p>Your current API key is invalid. Please input a valid key.
If this is in error, contact <a href="https://www.torn.com/profiles.php?XID=1946152">sullengenie [1946152]</a>.</p>`),
                                         document.getElementById('sullen-api-key-input').previousElementSibling));
  }

  function removeApiKeyWarning() {
    apiKeyInputCreated.then(() => {
      let warning = document.getElementById('sullen-api-key-input').previousElementSibling.previousElementSibling;
      if (warning) {
        warning.remove();
      }
    });
  }

  function submitApiKey() {
    apiKey = document.getElementById('sullen-api-key-input').value;
    fetch(host+'users', {
      method: 'POST',
      body: JSON.stringify({ api_key: apiKey }),
      headers: {"Content-Type": "application/json"}
    })
      .then(resp => resp.json())
      .then(data => handleApiKeyResponse(data));
  }

  function handleApiKeyResponse(data) {
    if (data.success) {
      hideApiKeyInput();
      GM_setValue('apiKey', apiKey);
      updatePlayerInfo();
    } else if (data.error) {
      handleInvalidApiKey();
    }
  }

  function handleInvalidApiKey() {
    // console.log('Invalid API key');
    GM_deleteValue('apiKey');
    showApiKeyInput();
    addApiKeyWarning();
  }

  function handleUnauthorizedFaction() {
    // console.log('Unauthorized faction');
    waitForPageLoad()
      .then(() => insertBefore(createHtml(`<p>Unauthorized faction.
If this is in error, please contact <a href="https://www.torn.com/profiles.php?XID=1946152">sullengenie [1946152]</a>.</p>`),
                               topProfileContainer()));
  }

  function updateTags(f) {
    let tags = JSON.parse(localStorage.automaticProfileInfo || '{}');
    f(tags);
    localStorage.automaticProfileInfo = JSON.stringify(tags);
  }

  function storePlayerInfo(vals) {
    updateTags(tags => tags[playerId] = Object.assign(tags[playerId] || {}, vals));
  }

  function fetchPlayerInfo() {
    return fetch(host+'players', {
      method: 'POST',
      body: JSON.stringify({ids: [playerId], api_key: apiKey}),
      headers: {"Content-Type": "application/json"}
    });
  }

  function handlePlayerInfoResponse(data) {
    // console.log('Player info response:');
    // console.log(data);
    if (data.error === 'Unauthorized faction') {
      waitForPageLoad().then(() => handleUnauthorizedFaction());
    } else if (data.error && data.error.includes('Unknown API key')) {
      waitForPageLoad().then(() => handleInvalidApiKey());
    } else {
      storePlayerInfo(data[playerId]);
      document.getElementById('sullen-update-button').click();
    }
  }

  function waitForPageLoad() {
    return new Promise(function(resolve, reject) {
      if (document.querySelector('div.user-information')) {
        resolve(true);
      }
      let target = document.getElementById('profileroot').firstElementChild;
      let observer = new MutationObserver(function(mutations) {
        this.disconnect();
        resolve(true);
      });
      // configuration of the observer:
      let config = { attributes: true, childList: true, characterData: true };
      // pass in the target node, as well as the observer options
      observer.observe(target, config);
    });
  }

  function updatePlayerInfo() {
    return fetchPlayerInfo()
      .then(resp => resp.json())
      .then(data => handlePlayerInfoResponse(data))
      .catch(e => console.log(e));
  }

  function main() {
    apiKey = GM_getValue('apiKey');
    // console.log('apiKey: ' + apiKey);
    if (apiKey !== undefined) {
      updatePlayerInfo();
    }

    apiKeyInputCreated = waitForPageLoad().then(() => createApiKeyInput());

    document.body.appendChild(createHtml('<style id="api-key-container-style"></style>'));
    if (apiKey !== undefined) {
      hideApiKeyInput();
    } else {
      showApiKeyInput();
    }

    GM_addStyle(`
.vinkuun-button { cursor: pointer }
.vinkuun-button div.btn { padding: 0 10px 0 7px !important }`);
  }

  main();

})();
