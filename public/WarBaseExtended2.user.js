// ==UserScript==
// @name        War Base Extended
// @namespace   vinkuun.warBaseExtended
// @author      Vinkuun [1791283]
// @description Brings back the old war base layout, adds a filter to the war base, enables enemy tagging
// @include     *.torn.com/factions.php?step=your*
// @include     *.torn.com/profiles.php?XID=*
// @version     2.4.40
// @require      https://code.jquery.com/jquery-2.2.0.min.js
// @grant       GM_addStyle
// ==/UserScript==

'use strict';

this.$ = this.jQuery = jQuery.noConflict(true);

// global CSS
GM_addStyle(
  '#vinkuun-extendedWarBasePanel { line-height: 2em }' +
    '#vinkuun-extendedWarBasePanel label { background-color: rgba(200, 195, 195, 1); padding: 2px; border: 1px solid #fff; border-radius: 5px }' +
    '#vinkuun-extendedWarBasePanel input { margin-right: 5px; vertical-align: text-bottom }' +
    '#vinkuun-extendedWarBasePanel input[type="number"] { vertical-align: baseline; line-height: 1.3em }' +
    '#vinkuun-extendedWarBasePanel { padding: 4px; }'
);

var $MAIN = $('#faction-main');

// ============================================================================
// --- FEATURE: War Base Layout
// ============================================================================
function enableWarBaseLayout() {
  var fragment = document.createDocumentFragment();

  $('.f-war-list .desc-wrap').each(function() {
    var row = document.createElement('li');
    row.classList.add('descriptions');

    $(this.children).each(function() {
      row.appendChild(this);
    });

    fragment.appendChild(row);
  });

  $('.f-war-list li:not(.clear)').remove();

  $('.f-war-list').prepend(fragment);

  $('.f-msg').css('margin-bottom', '10px');

  GM_addStyle(
    '.f-war-list .descriptions { margin-top: 10px !important; border-radius: 5px !important }' +
      '.f-war-list .descriptions .status-desc { border-radius: 5px 5px 0 0 !important }'
  );
}

// ============================================================================
// --- FEATURE: War base filter
// ============================================================================
var warBaseFilter;
var $filterStatusElement;

/**
 * Adds the filter panel to the war base extended main panel
 * @param {jQuery-Object} $panel Main panel
 */
function addWarBaseFilter($panel) {
  var $warList = $('.f-war-list');
  var $statusElement = $('<p>', {text: 'The war base is currently hidden. Click the bar above to show it.', style: 'text-align: center; margin-top: 4px; font-weight: bold'}).hide();

  $('.f-msg')
    .css('cursor', 'pointer')
    .on('click', function() {
      if (shouldHideWarBase()) {
        localStorage.vinkuunHideWarBase = false;
        $warList.show();
        $statusElement.hide();
      } else {
        localStorage.vinkuunHideWarBase = true;
        $warList.hide();
        $statusElement.show();
      }})
    .attr('title', 'Click to show/hide the war base')
    .after($statusElement);

  if (shouldHideWarBase()) {
    $warList.hide();
    $statusElement.show();
  }

  // load saved war base filter settings
  warBaseFilter = JSON.parse(localStorage.vinkuunWarBaseFilter || '{}');
  warBaseFilter.status = warBaseFilter.status || {};

  $filterStatusElement = $('<span>', {text: 0});

  addFilterPanel($panel);

  applyFilter();
}


function sort_list_by_id(a,b){
  var userID_a = $(a).find("div.member").find("span.t-show").find("a.user.name").attr("href").split("=")[1];
  var userID_b = $(b).find("div.member").find("span.t-show").find("a.user.name").attr("href").split("=")[1];
  userID_a     = parseInt(userID_a);
  userID_b     = parseInt(userID_b);
  if(warBaseFilter.status.young){
    return userID_b > userID_a ? 1 : -1;
  } else {
    return userID_b < userID_a ? 1 : -1;
  }
}

// returns true if the layout is enabled, false if not
function shouldHideWarBase() {
  return JSON.parse(localStorage.vinkuunHideWarBase || 'false');
}

var divisor;
/**
 * Applys the filter to the war base
 *
 * @param  {jquery-Object} $list
 * @param  {Object} filter
 */
function applyFilter() {
  $("#orderedList").remove();
  var $list = $MAIN.find('ul.f-war-list');

  // show all members
  $list.find('li').show();
  divisor = 1;
  if(warBaseFilter.status.sortedList) {
    var $userList = $list.find('div.lvl').parent().clone();
    $list.prepend('<ul id="orderedList" class="member-list bottom-round t-blue-cont h"></ul>');
    $userList.sort(sort_list_by_id).appendTo('#orderedList');
    divisor = 2;
  }
  var countFiltered = 0;
  var totalEnemies  = $list.find("span.t-hide").find("a.user.name").length;
  var items;

  //Sort within faction
  $('ul.f-war-list > li').each(function(){
    var factionList = $(this).find('ul.member-list')
    var factionPeople = $(this).find('div.lvl').parent();
    factionPeople.sort(sort_list_by_id);
    $.each(factionPeople,function(i,li){
      factionList.append(li);
    });
  });

  if (warBaseFilter.status.okay) {
    items = $list.find('span:contains("Okay")');
    countFiltered += items.length;

    items.parent().parent().hide();
  }

  if (warBaseFilter.status.traveling) {
    items = $list.find('span:contains("Traveling")');
    countFiltered += items.length;

    items.parent().parent().hide();
  }
  if (warBaseFilter.status.federal) {
    items = $list.find('span:contains("Federal")');
    countFiltered += items.length;

    items.parent().parent().hide();
  }

  if (warBaseFilter.status.hospital) {
    $list.find('span:contains("Hospital")').each(function() {
      var $this = $(this);

      var $li = $this.parent().parent();
      var title = $li.find('.member-icons #icon15').attr('title');
      if (typeof title === 'undefined')
        return;
      var hospitalTimeLeft = remainingHospitalTime(title);

      if (hospitalTimeLeft > warBaseFilter.status.hospital) {
        countFiltered++;
        $li.hide();
      }
    });
  }
  if(warBaseFilter.status.general) {
    $list.find('.member-icons #icon21[title="<b>Job</b><br>General in the Army"]').each(function(){
      if ( $(this).parent().parent().parent().css('display') != 'none' ){
        countFiltered += 1;
        $(this).parent().parent().parent().hide();
      }
    });
  }

  if (warBaseFilter.status.hLevel) {
    $list.find("div.lvl").each(function(){
      var level = parseInt($(this).clone().children().remove().end().text().trim());
      if(level < warBaseFilter.status.hLevel){
        if ( $(this).parent().css('display') != 'none' ){
          // element is still visible
          $(this).parent().hide();
          countFiltered++;
        }
      }
    });
  }

  if (warBaseFilter.status.lLevel) {
    $list.find("div.lvl").each(function(){
      var level = parseInt($(this).clone().children().remove().end().text().trim());
      if(level > warBaseFilter.status.lLevel){
        if ( $(this).parent().css('display') != 'none' ){
          // element is still visible
          $(this).parent().hide();
          countFiltered++;
        }
      }
    });
  }
  // Filter by userID
  if (warBaseFilter.status.userID) {
    //console.log($("#faction-main > ul > li:nth-child(16) > div.desc-wrap > div.viewport > div > ul > li:nth-child(4) > div.member.icons > span > a").data("data-placeholder"));
    $list.find("div.member").find("span.t-show").find("a.user.name").each(function(){
      var userID = $(this).attr("href").split("=")[1];
      //userID     = parseInt(userID.substring(1,userID.length-1));
      if(userID < warBaseFilter.status.userID){
        if ( $(this).parent().parent().parent().css('display') != 'none' ){
          $(this).parent().parent().parent().hide();
          countFiltered++;
        }
      }
    });
  }
  // Filter by xanax used
  if (warBaseFilter.status.xanax) {
    $list.find("div.member").find("span.t-show").find("a.user.name").each(function(){
      var userID = $(this).attr("href").split("=")[1];
      var totalXanax = enemyXan[userID];
      if(totalXanax > warBaseFilter.status.xanax){
        if ( $(this).parent().parent().parent().css('display') != 'none' ){
          $(this).parent().parent().parent().hide();
          countFiltered++;
        }
      }
    });
  }
  // Filter by refills
  if (warBaseFilter.status.refill) {
    $list.find("div.member").find("spna.t-show").find("a.user.name").each(function(){
      var userID = $(this).attr("href").split("=")[1];
      var totalRefill = enemyRef[userID];
      if(totalRefill > warBaseFilter.status.refill){
        if ( $(this).parent().parent().parent().css('display') != 'none' ){
          $(this).parent().parent().parent().hide();
          countFiltered++;
        }
      }
    });
  }

  if (warBaseFilter.status.se) {
    $list.find("div.member").find("spna.t-show").find("a.user.name").each(function(){
      var userID = $(this).attr("href").split("=")[1];
      var totalSE = enemySE[userID];
      if(totalSE > warBaseFilter.status.se){
        if ( $(this).parent().parent().parent().css('display') != 'none' ){
          $(this).parent().parent().parent().hide();
          countFiltered++;
        }
      }
    });
  }

  if (warBaseFilter.status.impossible) {
    $list.find("div.member").find("spna.t-show").find("a.user.name").each(function(){
      var userID = $(this).attr("href").split("=")[1];
      var difficulty = enemyTags[userID];
      var sullenDifficulty = sullenEnemyTags[userID];
      if(difficulty === 'impossible' ||
         (sullenDifficulty && sullenDifficulty[0] === 'impossible' && sullenDifficulty[1] > 0.6)){
        if ( $(this).parent().parent().parent().css('display') != 'none' ){
          $(this).parent().parent().parent().hide();
          countFiltered++;
        }
      }
    });
  }


  // update the number of hidden members
  var enemiesShown = totalEnemies - countFiltered
  $filterStatusElement.text('Total enemies: ' + totalEnemies/divisor + '. Enemies found: ' + enemiesShown/divisor + '. Enemies filtered: ' + countFiltered/divisor + '.');
}

//Creates a nice looking infor box. From tornstats
function createInfoBox(msg) {
  return $('<div class="info-msg-cont border-round m-top10"><div class="info-msg border-round">' +
           '<i class="info-icon"></i><div class="delimiter"><div class="msg right-round">' +
           msg +
           '</div></div>' +
           '</div></div>');
}

var enemyXan = JSON.parse(localStorage.vinkuunEnemyXan || '{}');
var enemyRef = JSON.parse(localStorage.vinkuunEnemyRef || '{}');
var enemySE = JSON.parse(localStorage.vinkuunEnemySE || '{}');

//Get and store xanax, SE, refills
function getXanEtcFull(){
  enemyXan = {};
  enemySE  = {};
  enemyRef = {};
  //Create info box:
  var count = $MAIN.find('ul.f-war-list').find('ul.member-list').not("#orderedList").find("div.member").find("spna.t-show").find("a.user.name").length;
  var countSave = count;
  var minutes = Math.ceil(count/30) + 1;
  var infoBox = createInfoBox("Reseting xanax, refill, and se counters of " + countSave + " people. This should take around " + minutes + " minutes...").insertBefore('#vinkuun-extendedWarBasePanel');

  $MAIN.find('ul.f-war-list').find('ul.member-list').not("#orderedList").find("div.member").find("spna.t-show").find("a.user.name").each(function(k,v){
    var userID = $(this).attr("href").split("=")[1];
    var link = 'personalstats.php?ID=' + userID;
    setTimeout(function (){
      //console.log(link);
      requestPage(link,true,handler_personal_stats,userID);
      if(k != 0) {
        if(k%10 == 0) {
          infoBox.find("div.msg").text("Still updating... " + k + " out of " + countSave + " completed so far.");
        }
      }
      if(!--count) {
        infoBox.find("div.msg").text("Done updating! Click to remove this message.");
        infoBox.click(function(){
          $(this).remove();
        });
      }
    }, k*2000);
  });
}

//Get and store xanax, SE, refills
function getXanEtcUpdate(){
  var j = 0;
  var countTot = $MAIN.find('ul.f-war-list').find('ul.member-list').not("#orderedList").find("div.member").find("spna.t-show").find("a.user.name").length;
  var countMiss = 0;
  //Do a quick count of those remaining
  $MAIN.find('ul.f-war-list').find('ul.member-list').not("#orderedList").find("div.member").find("spna.t-show").find("a.user.name").each(function(k,v){
    var userID = $(this).attr("href").split("=")[1];
    if(enemyXan[userID]===undefined || enemyRef[userID]===undefined || enemySE[userID]===undefined){
      countMiss++
    }
  });
  countMiss = countMiss;
  var minutes = Math.ceil(countMiss/30) + 1;

  var infoBox = createInfoBox("Updating missing xanax, refill, and se counters of " + countMiss + " people. This should take less than " + minutes + " minutes...").insertBefore('#vinkuun-extendedWarBasePanel');

  var countMissStore = countMiss;
  if(countMiss != 0) {
    $MAIN.find('ul.f-war-list').find('ul.member-list').not("#orderedList").find("div.member").find("spna.t-show").find("a.user.name").each(function(k,v){
      var userID = $(this).attr("href").split("=")[1];
      if(enemyXan[userID]===undefined || enemyRef[userID]===undefined || enemySE[userID]===undefined){
        j++;
        var link = 'personalstats.php?ID=' + userID;
        setTimeout(function (){
          requestPage(link, true, handler_personal_stats,userID);

          if(!--countMiss) {
            infoBox.find("div.msg").text("Done updating! Click to remove this message.");
            infoBox.click(function(){
              $(this).remove();
            });
          }
        }, j*2000);
      }
    });
  } else {
    infoBox.find("div.msg").text("No data missing. Nothing updated. Click to remove this message.");
    infoBox.click(function(){
      $(this).remove();
    });
  }
}

function requestPage(link, modo, handler,id){
  var httpRequest = new XMLHttpRequest();
  httpRequest.onreadystatechange = handler(id);
  httpRequest.open('GET', link, modo);
  try{ httpRequest.send(null); } catch(x){ //alert(x);
  };
  return httpRequest.responseText;
}

function handler_personal_stats(id){
  return function(){
    if(this.readyState == 4 && this.status == 200) {
      if(this.responseText != null){
        var html = this.responseText;

        if(html.match(/data-val\='xantaken'>/g) ){
          var match = html.match(/<li data-val\='xantaken'><span class\='name'>Xanax taken:<\/span><span class='value (t-red|t-green)?'>((\d+,)?(\d+))<\/span><\/li>/g);
          var match2 = match[1].match(/<li data-val\='xantaken'><span class\='name'>Xanax taken:<\/span><span class='value (t-red|t-green)?'>((\d+,)?(\d+))<\/span><\/li>/);
          var totalXan = parseInt(match2[2].replace(/,/g, ""));
          enemyXan[id] = totalXan;
          //debug statement below
          //console.log('Total Xan: ' + id + ' ' + totalXan);
          //Store in local storage
          localStorage.vinkuunEnemyXan = JSON.stringify(enemyXan);
        }

        if(html.match(/data-val\='refils'/g) ){
          var match = html.match(/<li data-val\='refils'><span class\='name'>Energy refills:<\/span><span class='value (t-red|t-green)?'>((\d+,)?(\d+))<\/span><\/li>/g);
          var match2 = match[1].match(/<li data-val\='refils'><span class\='name'>Energy refills:<\/span><span class='value (t-red|t-green)?'>((\d+,)?(\d+))<\/span><\/li>/);
          var totalRef = parseInt(match2[2].replace(/,/g, ""));
          enemyRef[id] = totalRef;
          //debug statement below
          //console.log('Total Ref: ' + id + ' ' + totalRef);
          //Store in local storage
          localStorage.vinkuunEnemyRef = JSON.stringify(enemyRef);
        }

        if(html.match(/data-val\='statenhancersused'>/g) ){
          var match = html.match(/<li data-val\='statenhancersused'><span class\='name'>Stat enhancers used:<\/span><span class='value (t-red|t-green)?'>((\d+,)?(\d+))<\/span><\/li>/g);
          var match2 = match[1].match(/<li data-val\='statenhancersused'><span class\='name'>Stat enhancers used:<\/span><span class='value (t-red|t-green)?'>((\d+,)?(\d+))<\/span><\/li>/);
          var totalSE = parseInt(match2[2].replace(/,/g, ""));
          enemySE[id] = totalSE;
          //debug statement below
          //console.log('Total SE: ' + id + ' ' + totalSE);
          //Store in local storage
          localStorage.vinkuunEnemySE = JSON.stringify(enemySE);

        }
      }
    }
  }
}

//Highlight bonus faction with light blue
function highLightBonus(){
  var factions = $("#selectFaction").val();
  localStorage.factions = JSON.stringify(factions);
  var $list = $MAIN.find('.member-list > li').each(function() {
    //        var faction = $(this).parents('div.desc-wrap').find('div.f-right').find('a.t-blue.h').text();
    try{
      var faction = $(this).find("#icon9").attr('title');
      if(faction.indexOf("Member") > -1) {
        faction = faction.split("Member of ")[1].trim();
      } else if(faction.indexOf("Co-leader of ") > -1){
        faction = faction.split("Co-leader of ")[1].trim();
      } else if(faction.indexOf("Leader of ") > -1){
        faction = faction.split("Leader of ")[1].trim();
      }
    }
    catch(err){
      var faction = '';
    }
    if($.inArray(faction,factions)>-1){
      $(this).find('div.member').css('background-color', 'rgba(166, 218, 255, 1)')
    } else {
      $(this).find('div.member').css('background-color', 'inherit')
    }
  })
  //applyFilter();
}


/**
 * Panel to configure the filter - will be added to the main panel
 */
function addFilterPanel($panel) {
  // sorted list at top
  $panel.append('<br>');
  var $sortedListCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {sortedList: this.checked}});
        });
  var $sortedListElement = $('<label>', {text: ' Show full sorted list at top.'}).prepend($sortedListCheckbox);
  $panel.append($sortedListElement);

  // youngest at top
  var $youngCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {young: this.checked}});
        });
  var $youngElement = $('<label>', {text: ' Youngest first.'}).prepend($youngCheckbox);

  $panel.append($youngElement).append('<br> ');


  $panel.append("Hide enemies who are ");


  // status: traveling filter
  var $travelingCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {traveling: this.checked}});
        });
  var $travelingElement = $('<label>', {text: 'traveling'}).prepend($travelingCheckbox);
  $panel.append($travelingElement).append(', ');

  // status: okay filter
  var $okayCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {okay: this.checked}});
        });
  var $okayElement = $('<label>', {text: 'okay'}).prepend($okayCheckbox);
  $panel.append($okayElement).append(' or ');

  // status: federal filter
  var $federalCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {federal: this.checked}});
        });
  var $federalElement = $('<label>', {text: 'in federal prison'}).prepend($federalCheckbox);
  $panel.append($federalElement).append(', ');
  // status: impossible filter
  var $impossibleCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {impossible: this.checked}});
        });
  var $impossibleElement = $('<label>', {text: 'impossible'}).prepend($impossibleCheckbox);
  $panel.append($impossibleElement).append(', ');

  // status: general filter
  var $generalCheckbox = $('<input>', {type: 'checkbox'})
        .on('change', function() {
          reapplyFilter({status: {general: this.checked}});
        });
  var $generalElement = $('<label>', {text: 'general in army'}).prepend($generalCheckbox);
  $panel.append($generalElement).append(', ');

  // status: hospital filter
  var $hospitalTextfield = $('<input>', {type: 'number', style: 'width: 50px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {hospital: false}});
          } else {
            reapplyFilter({status: {hospital: parseInt(this.value, 10)}});
          }
        });
  var $hospitalElement = $('<label>', {text: 'in hospital for more than '})
        .append($hospitalTextfield)
        .append(' minutes<br>');
  $panel.append($hospitalElement);

  $panel.append("Show enemies who are ");

  // status: higer-level filter
  var $userIDTextfield = $('<input>', {type: 'number', style: 'width: 75px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {userID: false}});
          } else {
            reapplyFilter({status: {userID: parseInt(this.value, 10)}});
          }
        });
  var $userIDElement = $('<label>', {text: 'Higher than ID '})
        .append($userIDTextfield)
  $panel.append($userIDElement);

  // status: higer-level filter
  var $hLevelTextfield = $('<input>', {type: 'number', style: 'width: 50px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {hLevel: false}});
          } else {
            reapplyFilter({status: {hLevel: parseInt(this.value, 10)}});
          }
        });

  var $hLevelElement = $('<label>', {text: 'Higher than level '})
        .append($hLevelTextfield)
  $panel.append($hLevelElement);

  // status: lower-level filter
  var $lLevelTextfield = $('<input>', {type: 'number', style: 'width: 50px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {lLevel: false}});
          } else {
            reapplyFilter({status: {lLevel: parseInt(this.value, 10)}});
          }
        });
  var $lLevelElement = $('<label>', {text: 'Lower than level '})
        .append($lLevelTextfield)
  $panel.append($lLevelElement);


  $panel.append("<br>Hide enemies who have used more than ");

  // status: xanax filter
  var $xanaxTextfield = $('<input>', {type: 'number', style: 'width: 50px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {xanax: false}});
          } else {
            reapplyFilter({status: {xanax: parseInt(this.value, 10)}});
          }
        });
  var $xanaxElement = $('<label>')
        .append($xanaxTextfield)
        .append(' xanax');

  $panel.append($xanaxElement);


  // status: refill filter
  var $refillTextfield = $('<input>', {type: 'number', style: 'width: 50px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {refill: false}});
          } else {
            reapplyFilter({status: {refill: parseInt(this.value, 10)}});
          }
        });
  var $refillElement = $('<label>')
        .append($refillTextfield)
        .append(' refills');

  $panel.append($refillElement);

  // status: refill filter
  var $seTextfield = $('<input>', {type: 'number', style: 'width: 50px'})
        .on('change', function() {
          if (isNaN(this.value)) {
            reapplyFilter({status: {se: false}});
          } else {
            reapplyFilter({status: {se: parseInt(this.value, 10)}});
          }
        });
  var $seElement = $('<label>')
        .append($seTextfield)
        .append(' SEs');

  $panel.append($seElement);

  $panel.append('<br>').append($filterStatusElement);//.append(' enemies are hidden by the filter.)');

  //Create, place, and define click handler for refresh button
  // var button = createButton('Reset Full Xanax/Refill/SE').click(getXanEtcFull);
  // var button2 = createButton('Update Xanax/Refill/SE').click(getXanEtcUpdate);
  //var button3 = createButton('Refresh').click(refreshWarbase);
  // $panel.prepend(button);
  // $panel.prepend(button2);
  //$panel.prepend(button3)
  $panel.append("<br><b>Select Bonus Factions (will be highlighted in blue, hold ctrl to select multiple factions) </b><div id='bonusFaction'><select id='selectFaction' multiple></select></div>");
  //Get list of factions
  var factions = $('div.f-right').find('a.t-blue.h');
  var option = '';

  $(factions).each(function(){
    option += '<option value="'+ $(this).text() + '">' + $(this).text() + '</option>';
  });
  $('#selectFaction').append(option);
  $('#selectFaction').change(highLightBonus);
  var factions = JSON.parse(localStorage.factions || '[]');
  $('#selectFaction').val(factions);

  // set the states of the elements according to the saved filter
  $travelingCheckbox[0].checked = warBaseFilter.status.traveling || false;
  $sortedListCheckbox[0].checked = warBaseFilter.status.sortedList || false;
  $youngCheckbox[0].checked = warBaseFilter.status.young || false;

  $okayCheckbox[0].checked = warBaseFilter.status.okay || false;
  $federalCheckbox[0].checked = warBaseFilter.status.federal || false;
  $impossibleCheckbox[0].checked = warBaseFilter.status.impossible || false;

  $generalCheckbox[0].checked = warBaseFilter.status.general || false;

  $hospitalTextfield.val(warBaseFilter.status.hospital || '');
  $hLevelTextfield.val(warBaseFilter.status.hLevel || '');
  $lLevelTextfield.val(warBaseFilter.status.lLevel || '');
  $userIDTextfield.val(warBaseFilter.status.userID || '');
  $xanaxTextfield.val(warBaseFilter.status.xanax || '');
  $refillTextfield.val(warBaseFilter.status.refill || '');
  $seTextfield.val(warBaseFilter.status.se || '');

  //Sort within faction

}

//Creates a nice looking botton. From tornstats
function createButton(text) {
  return $('<div>', {
    'class': 'btn-wrap silver otter-button'
  }).append($('<div>', {
    'type': 'button',
    text: text
  }));
}

/**
 * Reapplies the war base filter - current settings will be merged with the new filter settings
 * @param  {Object} newFilter new filter settings
 */
function reapplyFilter(newFilter) {
  $.extend(true, warBaseFilter, newFilter);

  localStorage.vinkuunWarBaseFilter = JSON.stringify(warBaseFilter);

  applyFilter(warBaseFilter);
}

/**
 * Returns the remaining hospital time in minutes
 *
 * @param  {String} text The tooltip text of the hospital icon
 * @return {Integer}
 */
function remainingHospitalTime(text) {
  var match = text.match(/data-time='(\d+)'/);

  return match[1] / 60;
}


function addEnemyXanRefSE() {
  GM_addStyle(
    'span.xan-icon {     display: inline-block; vertical-align: middle; height: 16px; width: 16px; float: left;  margin-right: 10px; margin-bottom: 0px; background-image: url("https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/26/pill.png") !important; background-repeat: no-repeat; background-size: 16px 16px; }' +
      'span.ref-icon {     display: inline-block; vertical-align: middle; height: 16px; width: 16px; float: left;  margin-right: 10px; margin-bottom: 0px; background-image: url("https://cdn0.iconfinder.com/data/icons/social-productivity-line-art-2/128/refresh-2-16.png") !important; background-repeat: no-repeat; background-size: 16px 16px; }' +
      'span.se-icon {     display: inline-block; vertical-align: middle; height: 16px; width: 16px; float: left;  margin-right: 10px; background-image: url("https://cdn4.iconfinder.com/data/icons/mosaicon-04/512/chart-16.png") !important; background-repeat: no-repeat; background-size: 16px 16px; }' +
      '.member-list li div.status, .member-list li div.act-cont { font-weight: bold }'
  );

  if($('#iconTray').hasClass('sml')){
    var size = 12;
  } else if($('#iconTray').hasClass('big')) {
    var size = 16;
  } else {
    var size = 14;
  }
  var $list = $MAIN.find('.member-list > li').each(function() {
    var $this = $(this);
    //Remove all boy girl icons
    $this.find('#icon6').remove();
    $this.find('#icon7').remove();
    //remove donator icons
    $this.find('#icon3').remove();
    //remove subscriber icons
    $this.find('#icon4').remove();
    //remove married icons
    $this.find('#icon8').remove();
    var id = $this.find('.user.name').eq(0).attr('href').match(/XID=(\d+)/)[1];
    $this.find('.member-icons > #iconTray').append('<li class="iconShow" style="display:inline-block;background-image: url(\'https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/26/pill.png\');background-size: ' + size  + 'px ' + size + 'px" title="Xanax taken: ' + enemyXan[id] + '"></li');
    $this.find('.member-icons > #iconTray').append('<li class="iconShow" style="display:inline-block;background-image: url(\'https://cdn0.iconfinder.com/data/icons/social-productivity-line-art-2/128/refresh-2-16.png\');background-size: ' + size  + 'px ' + size + 'px" title="Refills used: ' + enemyRef[id] + '"></li>');
    $this.find('.member-icons > #iconTray').append('<li class="iconShow" style="display:inline-block;background-image: url(\'https://cdn4.iconfinder.com/data/icons/mosaicon-04/512/chart-16.png\');background-size: ' + size  + 'px ' + size + 'px" title="SEs used: ' + enemySE[id] + '"></li>');

  });
}

// ============================================================================
// --- FEATURE: Enemy tagging
// ============================================================================

var TAGS = {
  tbd: {text: 'Difficulty', color: 'inherit'},
  easy: {text: 'Easy', color:'rgba(161, 248, 161, 1)'},
  medium: {text: 'Medium', color:'rgba(231, 231, 104, 1)'},
  impossible: {text: 'Impossible', color:'rgba(242, 140, 140, 1)'}
};

var enemyTags = JSON.parse(localStorage.vinkuunEnemyTags || '{}');
var sullenEnemyTags = JSON.parse(localStorage.sullenEnemyTags || '{}');

function addEnemyTagging() {
  GM_addStyle(
    'select.vinkuun-enemeyDifficulty { font-size: 12px; vertical-align: text-bottom; margin-bottom:7px }' +
      '.member-list li div.status, .member-list li div.act-cont { font-weight: bold }'
  );

  var $list = $MAIN.find('.member-list > li').each(function() {
    var $this = $(this);

    var id = $this.find('.user.name').eq(0).attr('href').match(/XID=(\d+)/)[1];

    $this.find('.member-icons').prepend(createDropdown($this, id));
  });
}

function createDropdown($li, id) {
  var $dropdown = $('<select>', {'class': 'vinkuun-enemeyDifficulty'}).on('change', function() {
    var tag = $(this).val();
    if (tag === "tbd") {
      delete enemyTags[id];
    }
    else {
      enemyTags[id] = tag;
    }

    localStorage.vinkuunEnemyTags = JSON.stringify(enemyTags);

    updateColor($li, id);
  });

  $.each(TAGS, function(key, value) {
    var $el = $('<option>', {value: key, text: value.text});

    if (enemyTags[id] && key === enemyTags[id]) {
      $el.attr('selected', 'selected');
    }

    $dropdown.append($el);
  });

  updateColor($li, id);

  return $dropdown;
}

function updateColor($li, id) {
  if (enemyTags[id]) {
    $li.css('background-color', TAGS[enemyTags[id]].color);
  }
}

// ============================================================================
// --- MAIN
// ============================================================================

/**
 * Shows/Hides the control panel according to the current tab
span control panel
 */
function addUrlChangeCallback($element) {
  var urlChangeCallback = function () {
    if (window.location.hash === '#/tab=main' || window.location.hash === '') {
      $element.show();
    } else {
      $element.hide();
    }
  };

  // call it one time to show/hide the panel after the page has been loaded
  urlChangeCallback();

  // listen to a hash change
  window.onhashchange = urlChangeCallback;
}

/**
 * Initialises the script's features
 */
function init() {
  var $warBaseExtendedPanel = $('#vinkuun-extendedWarBasePanel');

  if ($warBaseExtendedPanel.length !== 0) {
    $warBaseExtendedPanel.empty();
  } else {
    $warBaseExtendedPanel = $('<div>', { id:'vinkuun-extendedWarBasePanel' });
    $MAIN.before($warBaseExtendedPanel);
  }

  var $title = $('<div>', { 'class': 'title-black m-top10 title-toggle tablet active top-round', text: 'War Base Extended' });
  $MAIN.before($title);

  var $panel = $('<div>', { 'class': 'cont-gray10 bottom-round cont-toggle', 'id': 'wbe-panel'});
  $MAIN.before($panel);

  $warBaseExtendedPanel.append($title).append($panel);

  enableWarBaseLayout();
  addEnemyXanRefSE();
  addWarBaseFilter($panel);
  addEnemyTagging();
  highLightBonus();

  $warBaseExtendedPanel.show();
  addUrlChangeCallback($warBaseExtendedPanel);
}
/**
 * Adds CSS to the HEAD of the document
span
 */
function addCss(css) {
  var head = document.head,
      style = document.createElement('style');

  style.type = 'text/css';
  style.appendChild(document.createTextNode(css));

  head.appendChild(style);
}


var currentPage = window.location.href;

if (currentPage.indexOf('torn.com/') !== -1) {
  addCss(
    '.otter-button { cursor: pointer }' +
      '.otter-button div.btn { padding: 0 10px 0 7px !important }'
  );
}

function initWarBase() {
  try {
    // observer used to apply the filter after the war base was loaded via ajax
    var observer = new MutationObserver(function(mutations) {
      mutations.forEach(function(mutation) {
        var i;
        for (i = 0; i < mutation.addedNodes.length; i++) {
          if (mutation.addedNodes.item(i).className === 'faction-respect-wars-wp') {
            // The main content is being added to the div
            init();
            $('#vinkuun-extendedWarBasePanel').show();
          }
        }
      });
    });

    // start listening for changes
    var observerTarget = $MAIN[0];
    var observerConfig = { attributes: false, childList: true, characterData: false };
    observer.observe(observerTarget, observerConfig);
  } catch (err) {
    console.log(err);
  }
}

function initProfileTargetIndicator() {
  var userId = location.search.split('=')[1];

  var attackButton = $('li.action-icon-attack a');

  if (enemyTags[userId]) {
    attackButton.css({
      'background-color': TAGS[enemyTags[userId]].color || 'rgb(132, 129, 129)',
      'border-radius': '5px'
    });

    if (typeof(enemyTags[userId]) === "string") {
      attackButton.attr('title', 'Difficulty: ' + enemyTags[userId]);
    } else {
      attackButton.attr('title', 'Difficulty: ' + enemyTags[userId][0] + ' (' + Math.floor(enemyTags[userId][1]*100) + '% likely)');
    }
  }
}

if (location.href.indexOf('torn.com/profiles.php?XID=') !== -1) {
  initProfileTargetIndicator();
} else if (location.href.indexOf('torn.com/factions.php') !== -1) {
  initWarBase();
}
