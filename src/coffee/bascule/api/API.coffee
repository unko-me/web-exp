Config = require '../Config'

APIRequest = require './APIRequest'
AjaxPool = require './AjaxPool'
API_BASE = Config.apiBase
#S3AssetsItems = require './S3AssetsItems'


class API
  constructor: () ->

    ###
    post likes/create
    @params motion_id {number}
    @params retryNum {number}
    @return $.Deferred
    ###
#  @likes_create: (motion_id, retryNum = 3)->
#    APIRequest.post(API_BASE + '/likes/create', {motion_id}, retryNum)

  ###
  GET /api/v1/players/{player_uuid}/story
  ###
  @player_story: (player_uuid, retryNum = 3)->
    url = "players/#{player_uuid}/story"
    APIRequest.get(API_BASE + url, null, retryNum)

  @player_statistics: (player_uuid, retryNum = 3)->
    url = "players/#{player_uuid}/result_stats"
    APIRequest.get(API_BASE + url, null, retryNum)

  ###
  テスト用 user_create → 122 round play
  ###
  @test_player: (retryNum = 0)->
    APIRequest.post(API_BASE + 'users/create', {os_name: "ios", device_name: "test"}, retryNum).then((data)->
      APIRequest.get(API_BASE + 'events/list.json', null, retryNum).then((data1)->
        window.data ?= {}
        window.data.events_list = data1

        round_id = data1[data1.length - 1].rounds[0].round_id
        APIRequest.post(API_BASE + "rounds/#{round_id}/play", {user_uuid: data.uuid}).then((data2)->
          console.log "new USER------ user_uuid:", data.uuid, 'player.uuid:',data2.uuid
          window.vars = {user_id: data.uuid, uuid: data2.uuid, round_id: round_id}
        )
      )
    )
  @test_profile: (options, retryNum = 0)->
    APIRequest.post(API_BASE + "players/#{options.uuid}/profile", options, retryNum).then((data)->
      console.log "data", data
    )
  @test_exit: (uuid)->
    APIRequest.post(API_BASE + "players/#{uuid}/exit").then((data)->
      console.log "data", data
    )




  ###

  @params options {Object}
  @return $.Deferred
  ###
#  @shares_create: (options, retryNum = 3)->
#    APIRequest.post(API_BASE + '/shares/create', options, retryNum)




#-----------------------------------
# S3 Assets
#-----------------------------------
#  ###
#  モーションリスト取得
#  @return $.Deferred
#  ###
#  @getMotionList: ()->
#    APIRequest.get(S3AssetsItems.getMotionList())
#
#  ###
#  それぞれのモーションのLIKEデータのpath取得
#  @param {number} motion_id - モーションID
#  @return $.Deferred
#  ###
#  @getMotionItemLike: (motion_id)->
#    APIRequest.get(S3AssetsItems.getMotionItemLikesPath(motion_id, 50))
#
#  ###
#  すべてのモーションのLIKEデータのpath取得
#  @return $.Deferred
#  ###
#  @getMotionLikesList: ()->
#    APIRequest.get(S3AssetsItems.getMotionLikesListPath(50))
#
#  ###
#  すべてのモーションのLIKE + LOOPSのpath取得
#  @return $.Deferred
#  ###
#  @getMotionActionsList: ()->
#    APIRequest.get(S3AssetsItems.getMotionActionsListPath())
#
#
#  ###
#  シェア受けページのIDに紐づく情報のJSON path取得
#  @param {string} share_id - share id or location.search
#  @return $.Deferred
#  ###
#  @getSharedItemInfo: (share_id)->
#    APIRequest.get(S3AssetsItems.getSharesPath(share_id))

  @abortShareCreate:()->
    @abort(API_BASE + '/shares/create')


  @abort:(url)->
    ajax = AjaxPool.getFromURL(url)
    ajax?.abort?()




module.exports = exports = API