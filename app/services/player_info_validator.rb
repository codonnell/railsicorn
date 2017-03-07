require 'dry-validation'

class PlayerInfoValidator < Validator
  Schema = Dry::Validation.Schema do
    required(:rank).value(:str?)
    required(:level) { int? & gt?(0) }
    required(:gender).value(:str?)
    required(:signup).format?(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
    required(:awards) { int? & gteq?(0) }
    required(:friends) { int? & gteq?(0) }
    required(:enemies) { int? & gteq?(0) }
    required(:forum_posts).maybe(:int?)
    required(:karma) { int? & gteq?(0) }
    required(:role).value(included_in?:
      %w(Admin Officer Secretary Moderator Helper NPC Civilian Reporter))
    required(:donator).value(included_in?: [0, 1])
    required(:player_id) { int? & gt?(0) }
    required(:name) { int? | str? }
    required(:last_action).format?(/\d+ (minutes?|hours?|days?) ago/)
    required(:life).schema do
      required(:maximum) { int? & gteq?(0) }
    end
    required(:status).each(:str?)
    required(:job).schema do
      required(:company_id) { int? & gteq?(0) }
      required(:position).value(:str?)
    end
    required(:faction).schema do
      required(:position).value(:str?)
      required(:faction_id) { int? & gteq?(0) }
      required(:days_in_faction) { int? & gteq?(0) }
    end
    required(:married).schema do
      required(:spouse_id) { int? & gteq?(0) }
      required(:duration) { int? & gteq?(0) }
    end
    required(:personalstats).schema do
      optional(:logins) { int? & gteq?(0) }
      optional(:useractivity) { int? & gteq?(0) }
      optional(:attackslost) { int? & gteq?(0) }
      optional(:attackswon) { int? & gteq?(0) }
      optional(:attacksdraw) { int? & gteq?(0) }
      optional(:highestbeaten) { int? & gteq?(0) }
      optional(:bestkillstreak) { int? & gteq?(0) }
      optional(:defendslost) { int? & gteq?(0) }
      optional(:defendswon) { int? & gteq?(0) }
      optional(:defendsstalemated) { int? & gteq?(0) }
      optional(:xantaken) { int? & gteq?(0) }
      optional(:exttaken) { int? & gteq?(0) }
      optional(:traveltimes) { int? & gteq?(0) }
      optional(:networth).value(:int?)
      optional(:refills).maybe(:int?)
      optional(:statenhancersused) { int? & gteq?(0) }
      optional(:medicalitemsused) { int? & gteq?(0) }
      optional(:medstolen) { int? & gteq?(0) }
      optional(:weaponsbought) { int? & gteq?(0) }
      optional(:bazaarcustomers) { int? & gteq?(0) }
      optional(:bazaarsales) { int? & gteq?(0) }
      optional(:bazaarprofit) { int? & gteq?(0) }
      optional(:pointsbought) { int? & gteq?(0) }
      optional(:pointssold) { int? & gteq?(0) }
      optional(:itemsboughtabroad) { int? & gteq?(0) }
      optional(:itemsbought) { int? & gteq?(0) }
      optional(:trades) { int? & gteq?(0) }
      optional(:itemssent) { int? & gteq?(0) }
      optional(:auctionswon) { int? & gteq?(0) }
      optional(:auctionsells) { int? & gteq?(0) }
      optional(:moneymugged) { int? & gteq?(0) }
      optional(:attacksstealthed) { int? & gteq?(0) }
      optional(:attackcriticalhits) { int? & gteq?(0) }
      optional(:respectforfaction) { int? & gteq?(0) }
      optional(:roundsfired) { int? & gteq?(0) }
      optional(:yourunaway) { int? & gteq?(0) }
      optional(:theyrunaway) { int? & gteq?(0) }
      optional(:peoplebusted) { int? & gteq?(0) }
      optional(:failedbusts) { int? & gteq?(0) }
      optional(:peoplebought) { int? & gteq?(0) }
      optional(:peopleboughtspent) { int? & gteq?(0) }
      optional(:virusescoded) { int? & gteq?(0) }
      optional(:cityfinds) { int? & gteq?(0) }
      optional(:bountiesplaced) { int? & gteq?(0) }
      # optional(:bountiesreceived) { int? & gteq?(0) }
      optional(:bountiesreceived) { int? }
      optional(:bountiescollected) { int? & gteq?(0) }
      optional(:totalbountyreward) { int? & gteq?(0) }
      optional(:totalbountyspent) { int? & gteq?(0) }
      optional(:revives) { int? & gteq?(0) }
      optional(:revivesreceived) { int? & gteq?(0) }
      optional(:trainsreceived) { int? & gteq?(0) }
      optional(:drugsused) { int? & gteq?(0) }
      optional(:overdosed) { int? & gteq?(0) }
      optional(:meritsbought) { int? & gteq?(0) }
      optional(:personalsplaced) { int? & gteq?(0) }
      optional(:classifiedadsplaced) { int? & gteq?(0) }
      optional(:mailssent) { int? & gteq?(0) }
      optional(:factionmailssent) { int? & gteq?(0) }
      optional(:companymailssent) { int? & gteq?(0) }
      optional(:spousemailssent) { int? & gteq?(0) }
      optional(:largestmug) { int? & gteq?(0) }
      optional(:cantaken) { int? & gteq?(0) }
      optional(:kettaken) { int? & gteq?(0) }
      optional(:lsdtaken) { int? & gteq?(0) }
      optional(:opitaken) { int? & gteq?(0) }
      optional(:shrtaken) { int? & gteq?(0) }
      optional(:spetaken) { int? & gteq?(0) }
      optional(:pcptaken) { int? & gteq?(0) }
      optional(:victaken) { int? & gteq?(0) }
      optional(:chahits) { int? & gteq?(0) }
      optional(:heahits) { int? & gteq?(0) }
      optional(:axehits) { int? & gteq?(0) }
      optional(:grehits) { int? & gteq?(0) }
      optional(:machits) { int? & gteq?(0) }
      optional(:pishits) { int? & gteq?(0) }
      optional(:rifhits) { int? & gteq?(0) }
      optional(:shohits) { int? & gteq?(0) }
      optional(:smghits) { int? & gteq?(0) }
      optional(:piehits) { int? & gteq?(0) }
      optional(:slahits) { int? & gteq?(0) }
      optional(:argtravel) { int? & gteq?(0) }
      optional(:mextravel) { int? & gteq?(0) }
      optional(:dubtravel) { int? & gteq?(0) }
      optional(:hawtravel) { int? & gteq?(0) }
      optional(:japtravel) { int? & gteq?(0) }
      optional(:lontravel) { int? & gteq?(0) }
      optional(:soutravel) { int? & gteq?(0) }
      optional(:switravel) { int? & gteq?(0) }
      optional(:chitravel) { int? & gteq?(0) }
      optional(:cantravel) { int? & gteq?(0) }
      optional(:dumpfinds) { int? & gteq?(0) }
      optional(:dumpsearches) { int? & gteq?(0) }
      optional(:itemsdumped) { int? & gteq?(0) }
      optional(:daysbeendonator) { int? & gteq?(0) }
      optional(:caytravel) { int? & gteq?(0) }
      optional(:jailed) { int? & gteq?(0) }
      optional(:hospital) { int? & gteq?(0) }
      optional(:attacksassisted) { int? & gteq?(0) }
      optional(:bloodwithdrawn) { int? & gteq?(0) }
      optional(:missioncreditsearned) { int? & gteq?(0) }
      optional(:contractscompleted) { int? & gteq?(0) }
      optional(:dukecontractscompleted) { int? & gteq?(0) }
      optional(:missionscompleted) { int? & gteq?(0) }
    end
  end

  def schema
    Schema
  end
end
