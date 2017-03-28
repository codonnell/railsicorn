// ==UserScript==
// @name         Tornicorn3
// @namespace    sullengenie.Tornicorn3
// @version      0.6
// @description  Estimates how difficult torn players are to attack
// @author       sullengenie[1946152]
// @require      https://code.jquery.com/jquery-2.2.0.min.js
// @require      https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.6.15/browser-polyfill.min.js
// @require      https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.6.15/browser.min.js
// @connect      tornicorn.com
// @connect      localhost
// @connect      railsicorn.herokuapp.com
// @include      *.torn.com/factions.php?step=your*
// @include      *.torn.com/profiles.php?XID=*
// @grant        GM_addStyle
// @grant        GM_xmlhttpRequest
// ==/UserScript==

// Your code here...
this.$ = this.jQuery = jQuery.noConflict(true);
var apiKey = localStorage.sullenApiKey;
var HOST = "https://railsicorn.herokuapp.com/";
// var HOST = "http://localhost:3000/";

GM_addStyle(
  '#sullen-api-form label { background-color: rgba(200, 195, 195, 1); border: 1px solid #fff; border-radius: 5px }' +
    '#sullen-api-btn { animation: none 0s ease 0s 1 normal none running; background-blend-mode: normal; border: 0px none rgb(51, 51, 51); border-radius: 0px; border-collapse: separate; border-image-outset: 0px; border-image-repeat: stretch; border-image-slice: 100%; border-image-source: none; border-image-width: 1; bottom: auto; box-shadow: none; box-sizing: content-box; caption-side: top; clear: none; clip: auto; color: rgb(51, 51, 51); cursor: pointer; direction: ltr; display: block; empty-cells: show; float: none; font-family: Arial; font-kerning: auto; font-size: 12px; font-stretch: normal; font-style: normal; font-variant: normal; font-variant-ligatures: normal; font-weight: normal; height: 24px; image-rendering: auto; isolation: auto; left: auto; letter-spacing: normal; line-height: 24px; list-style: disc outside none; margin: 0px; max-height: none; max-width: none; min-height: 0px; min-width: 0px; mix-blend-mode: normal; motion: none 0px auto 0deg; object-fit: fill; object-position: 50% 50%; opacity: 1; orphans: auto; outline: rgb(51, 51, 51) none 0px; outline-offset: 0px; overflow-wrap: normal; overflow: visible; padding: 0px; page-break-after: auto; page-break-before: auto; page-break-inside: auto; pointer-events: auto; position: static; resize: none; right: auto; speak: normal; table-layout: auto; tab-size: 8; text-align: center; text-align-last: auto; text-decoration: none; text-indent: 0px; text-rendering: auto; text-shadow: none; text-overflow: clip; text-transform: none; top: auto; touch-action: auto; transition: all 0s ease 0s; unicode-bidi: normal; vertical-align: baseline; visibility: visible; white-space: normal; widows: 1; width: 125.406px; will-change: auto; word-break: normal; word-spacing: 0px; word-wrap: normal; z-index: auto; zoom: 1; -webkit-appearance: none; backface-visibility: visible; -webkit-background-clip: border-box; -webkit-background-composite: source-over; -webkit-background-origin: padding-box; border-spacing: 0px; -webkit-border-image: none; -webkit-box-align: stretch; -webkit-box-decoration-break: slice; -webkit-box-direction: normal; -webkit-box-flex: 0; -webkit-box-flex-group: 1; -webkit-box-lines: single; -webkit-box-ordinal-group: 1; -webkit-box-orient: horizontal; -webkit-box-pack: start; -webkit-box-reflect: none; -webkit-clip-path: none; -webkit-column-break-after: auto; -webkit-column-break-before: auto; -webkit-column-break-inside: auto; -webkit-column-count: auto; -webkit-column-gap: normal; -webkit-column-rule-color: rgb(51, 51, 51); -webkit-column-rule-style: none; -webkit-column-rule-width: 0px; -webkit-column-span: none; -webkit-column-width: auto; -webkit-filter: none; align-content: stretch; align-items: stretch; align-self: stretch; flex: 0 1 auto; flex-flow: row nowrap; justify-content: flex-start; -webkit-font-smoothing: auto; -webkit-highlight: none; -webkit-hyphenate-character: auto; -webkit-line-break: auto; -webkit-locale: auto; -webkit-margin-before-collapse: collapse; -webkit-margin-after-collapse: collapse; -webkit-mask-box-image-source: none; -webkit-mask-box-image-slice: 0 fill; -webkit-mask-box-image-width: auto; -webkit-mask-box-image-outset: 0px; -webkit-mask-box-image-repeat: stretch; -webkit-mask: none 0% 0% / auto repeat border-box border-box; -webkit-mask-composite: source-over; -webkit-mask-size: auto; order: 0; perspective: none; perspective-origin: 62.6979px 12px; -webkit-print-color-adjust: economy; -webkit-rtl-ordering: logical; shape-outside: none; shape-image-threshold: 0; shape-margin: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.180392); -webkit-text-combine: none; -webkit-text-decorations-in-effect: none; -webkit-text-emphasis-color: rgb(51, 51, 51); -webkit-text-emphasis-position: over; -webkit-text-emphasis-style: none; -webkit-text-fill-color: rgb(51, 51, 51); -webkit-text-orientation: vertical-right; -webkit-text-security: none; -webkit-text-stroke-color: rgb(51, 51, 51); -webkit-text-stroke-width: 0px; transform: none; transform-origin: 62.6979px 12px 0px; transform-style: flat; -webkit-user-drag: auto; -webkit-user-modify: read-only; -webkit-user-select: text; -webkit-writing-mode: horizontal-tb; -webkit-app-region: no-drag; buffered-rendering: auto; clip-path: none; clip-rule: nonzero; mask: none; filter: none; flood-color: rgb(0, 0, 0); flood-opacity: 1; lighting-color: rgb(255, 255, 255); stop-color: rgb(0, 0, 0); stop-opacity: 1; color-interpolation: sRGB; color-interpolation-filters: linearRGB; color-rendering: auto; fill: rgb(0, 0, 0); fill-opacity: 1; fill-rule: nonzero; marker-end: none; marker-mid: none; marker-start: none; mask-type: luminance; shape-rendering: auto; stroke: none; stroke-dasharray: none; stroke-dashoffset: 0px; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 4; stroke-opacity: 1; stroke-width: 1px; alignment-baseline: auto; baseline-shift: 0px; dominant-baseline: auto; text-anchor: start; writing-mode: horizontal-tb; vector-effect: none; paint-order: fill; cx: 0px; cy: 0px; x: 0px; y: 0px; r: 0px; rx: 0px; ry: 0px; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(0, 0, 0, 0); }'
);

function updateApiKey() {
  console.log('Updating API Key');
  $('.page-head-delimiter').after(
    $('<form>', {id: "sullen-api-form", action: "javascript:void(0)"}).append(
      $('<label>', {text: "API Key:"}).append($('<input>', {type: "text", id: "sullen-api-input"})),
      $('<div>', {class: "btn-wrap silver otter-button"})
        .append($('<div>', {class: "btn"})
                .append($('<input>', {cursor: "pointer", type: "submit", id: "sullen-api-btn", text: "Submit"})))));

  $('#sullen-api-form').submit(function() {
    apiKey = $('#sullen-api-input').val();
    $('#sullen-api-error, #sullen-api-form').remove();
    GM_xmlhttpRequest(
      {method: 'POST',
       url: HOST+'users',
       headers: {"Content-Type": "application/json"},
       data: JSON.stringify({ "api_key": apiKey }),
       onload: function( response ) {
         var data = JSON.parse(response.responseText);
         if (data.success) {
           localStorage.sullenApiKey = apiKey;
           console.log('Finished updating API key.');
           updatePlayers();
         }
         else {
           handleInvalidApiKey();
         }
       }});
  });
}

function handleInvalidApiKey() {
  $('.page-head-delimiter').after('<p id="sullen-api-error">Error: Invalid API key. Input a new api key above.</p>');
  updateApiKey();
}

function handleError(response) {
  console.log("Error:");
  console.log(response);
  if (response.status != 500)
    handleInvalidApiKey();
}

function downloadPlayerInfo(ids) {
  console.log("Getting difficulties...");
  GM_xmlhttpRequest(
    {method: 'POST',
     url: HOST+'players',
     data: JSON.stringify({"ids": ids, "api_key": apiKey}),
     headers: {"Content-Type": "application/json"},
     onload: function (response) {
       var respJSON = JSON.parse(response.responseText);
       if (!respJSON.error) {
         console.log("Finished getting difficulties.");
         updatePlayerInfo(JSON.parse(response.responseText));
       }
       else {
         handleError(response);
       }
     }});
}

var TAG_COLORS = {
  easy: 'rgba(161, 248, 161, 1)',
  medium: 'rgba(231, 231, 104, 1)',
  impossible: 'rgba(242, 140, 140, 1)'
};

function tag_color(difficulty) {
  if (typeof(difficulty) === "string")
    return TAG_COLORS[difficulty];
  // Replace alpha value in color
  return TAG_COLORS[difficulty[0]].substring(0, TAG_COLORS[difficulty[0]].length-2) + (difficulty[1]-0.33333333)*4/3 + ')';
}

function idFromLi( li ) {
  var link = li.querySelector('div.member.icons > span.t-hide > a.user.name');
  return parseInt(link.href.match(/XID=(\d+)/)[1]);
}


function updatePlayerInfo(players) {
  // console.log(players);
  var difficulties = {};
  for (var id in players) {
    if (players[id].difficulty !== 'unknown') {
      difficulties[id] = players[id].difficulty;
    }
  }
  updateEnemyTags(difficulties);
  updateEnemyStats(players);
}

function updateEnemyStats(players) {
  var enemyXan = JSON.parse(localStorage.vinkuunEnemyXan || '{}');
  var enemyRef = JSON.parse(localStorage.vinkuunEnemyRef || '{}');
  var enemySE = JSON.parse(localStorage.vinkuunEnemySE || '{}');
  for (var id in players) {
    enemyXan[id] = players[id]['xanax_taken'];
    enemyRef[id] = players[id]['refills'];
    enemySE[id] = players[id]['stat_enhancers_used'];
  }
  localStorage.vinkuunEnemyXan = JSON.stringify(enemyXan);
  localStorage.vinkuunEnemyRef = JSON.stringify(enemyRef);
  localStorage.vinkuunEnemySE = JSON.stringify(enemySE);
  localStorage.sullenFilterNeeded = "true";
}

function updateEnemyTags(difficulties) {
  var sullenEnemyTags = JSON.parse(localStorage.sullenEnemyTags || "{}");
  $.extend(sullenEnemyTags, difficulties);
  var vinkuunEnemyTags = JSON.parse(localStorage.vinkuunEnemyTags || "{}");
  var enemyTags = jQuery.extend({}, sullenEnemyTags, vinkuunEnemyTags);
  localStorage.sullenEnemyTags = JSON.stringify(sullenEnemyTags);
  if (location.href.indexOf('torn.com/profiles.php?XID=') !== -1) {
    var userId = location.search.split('=')[1];
    var attackButton = $('li.action-icon-attack a');
    if (enemyTags[userId]) {
      //console.log('Setting difficulty for ' + userId + ' to ' + tag_color(enemyTags[userId]));
      attackButton.css({
        'background-color': tag_color(enemyTags[userId]) || 'rgb(132, 129, 129)',
        'border-radius': '5px'
      });

      if (typeof(enemyTags[userId]) === "string") {
        attackButton.attr('title', 'Difficulty: ' + enemyTags[userId]);
      } else {
        attackButton.attr('title', 'Difficulty: ' + enemyTags[userId][0] + ' (' + Math.floor(enemyTags[userId][1]*100) + '% likely)');
      }
    }
  }
  else if (location.href.indexOf('torn.com/factions.php') !== -1) {
    $('.member-list > li').each(function(idx, li) {
      var id = idFromLi(li);
      if (enemyTags[id]) {
        li.style.backgroundColor = tag_color(enemyTags[id]);
      }
    });
  }
}

function updatePlayers() {
  var targetIDs;
  if (location.href.indexOf('torn.com/profiles.php?XID=') !== -1) {
    targetIDs = [parseInt(location.search.split('=')[1])];
  } else if (location.href.indexOf('torn.com/factions.php') !== -1) {
    var targets = $('.member-list > li > div.member.icons > span.t-hide > a.user.name');
    targetIDs = $.map(targets, function(target) {
      return parseInt(target.href.match(/XID=(\d+)/)[1]);
    });
  }
  if (targetIDs.length !== 0)
    downloadPlayerInfo(targetIDs);
}

function main() {
  if (!apiKey || apiKey === '') {
    updateApiKey();
  }
  else {
    // Color immediately, then recolor after server response
    updateEnemyTags({});
    updatePlayers();
  }
}


if (location.href.indexOf('torn.com/profiles.php?XID=') !== -1) {
  main();
} else if (location.href.indexOf('torn.com/factions.php') !== -1) {
  var target = document.querySelector('#faction-main');
  // create an observer instance
  var observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      var i;
      for (i = 0; i < mutation.addedNodes.length; i++) {
        //console.log(mutation.addedNodes.item(i));
        if (mutation.addedNodes.item(i).className === 'faction-respect-wars-wp') {
          console.log('War page initiated!');
          main();
        }
      }
    });
  });
  // configuration of the observer:
  var config = { attributes: true, childList: true, characterData: true };
  // pass in the target node, as well as the observer options
  observer.observe(target, config);
}
