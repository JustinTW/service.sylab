# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  aaResource =
    [
      [
        1,
        '<i class="icon-rss icon-3x"></i> Wifi 網路',
        'SSID: <code>sylab</code>',
        '密碼: <code>1qaz2wsx</code>',
        'online',
        '',
        'net'
      ]
      [
        2,
        '<i class="icon-folder-open-alt icon-2x"></i> NAS',
         'Address: <code>192.168.67.2</code>',
         'SYLab 帳號',
         'online',
         '限實驗室IP連入，<br>校外請先連Lab VPN。<br>支援 Windows CIFS & NFS & APF',
        'storage'
      ]
      [
        3,
        '<i class="icon-folder-open-alt icon-2x"></i> FTP',
         'Address: <code>tw.ftp.sh</code> Port: <code>12344</code>',
         "SYLab 帳號",
         'offline',
         '網卡被停權..',
        'storage'
      ]
      [
        4,
        '<i class="icon-desktop icon-2x"></i> Xen VPS',
        'Address: <code>xen.sylab.ee.ntu.edu.tw</code><br>
        <a target="_blank" class="btn btn-primary btn-mini" href="/xen/request"><i class="icon-share icon-white"></i> 線上申請</a>
        <a target="_blank" class="btn btn-primary btn-mini" href="http://xen.sylab.ee.ntu.edu.tw"><i class="icon-share icon-white"></i> 管理虛擬機器</a>',
        'SYLab 帳號',
        'online',
        '使用 SYLab 帳號 申請',
        'host'
      ]
      [
        5,
        '<i class="icon-th-large icon-2x"></i> RDP Win XP',
        'Address: <code>winxp.sylab.ee.ntu.edu.tw</code> Port:<code>3330</code><br>
        <a target="_blank" class="btn btn-primary btn-mini" href="/xen/request"><i class="icon-download-alt icon-white"></i> 下載連線設定檔</a>',
        'SYLab 帳號',
        'offline',
        '公用遠端桌面 Windows XP <br>建置中..',
        'host'
      ]
      [
        6,
        '<i class="icon-th-large icon-2x"></i> RDP Win 7',
        'Address: <code>win7.sylab.ee.ntu.edu.tw</code> Port:<code>3331</code><br>
        <a target="_blank" class="btn btn-primary btn-mini" href="/xen/request"><i class="icon-download-alt icon-white"></i> 下載連線設定檔</a>',
        'SYLab 帳號',
        'offline',
        '公用遠端桌面 Windows 7 <br>建置中..',
        'host'
      ]
      [
        7,
        '<i class="icon-th-large icon-2x"></i> RDP Win 8',
        'Address: <code>win8.sylab.ee.ntu.edu.tw</code> Port:<code>3332</code><br>
        <a target="_blank" class="btn btn-primary btn-mini" href="/xen/request"><i class="icon-download-alt icon-white"></i> 下載連線設定檔</a>',
        'SYLab 帳號',
        'offline',
        '公用遠端桌面 Windows 8 <br>建置中..',
        'host'
      ]
      [
        8,
        '<i class="icon-exchange icon-2x"></i> VPN',
        'Address: <code>sylab.ee.ntu.edu.tw</code>',
        '共用帳號: <code>www</code>',
        'online',
        '',
        'net'
      ]
      [
        9,
        '<i class="icon-exchange icon-2x"></i> OpenVPN',
        'Address: <code>sylab.ee.ntu.edu.tw</code> Port: <code>443</code><br>
        <a href="#" class="btn btn-primary btn-mini"><i class="icon-download-alt icon-white"></i> 連線程式 for Win x64</a>
        <a href="#" class="btn btn-info btn-mini"><i class="icon-file icon-white"></i> Sylab 憑證與設定檔</a>',
        'SYLab 帳號',
        'online',
        '',
        'net'
      ]
      [
        10,
        '<i class="icon-envelope-alt icon-2x"></i> Email',
        'Address: <code>mail.sylab.ee.ntu.edu.tw</code><br>
        <a target="_blank" class="btn btn-primary btn-mini" href="http://mail.sylab.ee.ntu.edu.tw/"><i class="icon-share icon-white"></i> 線上收信</a>
        <a target="_blank" class="btn btn-primary btn-mini" href="https://groups.google.com/a/sylab.ee.ntu.edu.tw/forum/?fromgroups#!forumsearch/"><i class="icon-share icon-white"></i> 群組信箱</a>
        <a target="_blank" class="btn btn-primary btn-mini" href="https://www.google.com/a/cpanel/sylab.ee.ntu.edu.tw/CPanelHome"><i class="icon-share icon-white"></i> 網域管理</a>',
        'SYLab 帳號',
        'online',
        '25G 個人信箱<br>{SYLab 帳號}@sylab.ee.ntu.edu.tw',
        'apps'
      ]
      [
        11,
        '<i class="icon-github-alt icon-2x"></i> GitLab',
        'Address: <code>git.sylab.ee.ntu.edu.tw</code><br>
        <a target="_blank" class="btn btn-primary btn-mini" href="http://gitlab.sylab.ee.ntu.edu.tw"><i class="icon-share icon-white"></i> 管理界面</a>',
        'SYLab 帳號',
        'offline',
        '建置中..',
        'storage apps'
      ]
      [
        12,
        '<i class="icon-film icon-2x"></i> Streming',
        'Address: <code>sylab.ee.ntu.edu.tw</code><br>
        <a target="_blank" class="btn btn-success btn-mini" href="http://gitlab.sylab.ee.ntu.edu.tw"><i class="icon-mobile-phone icon-white"></i> Qloud for Android</a>
        <a target="_blank" class="btn btn-inverse btn-mini" href="http://gitlab.sylab.ee.ntu.edu.tw"><i class="icon-mobile-phone icon-white"></i> Qloud for iPhone</a>
        <a target="_blank" class="btn btn-warning btn-mini" href="http://gitlab.sylab.ee.ntu.edu.tw"><i class="icon-mobile-phone icon-white"></i> Qloud for Windows8</a>',
        '共用帳號: <code>www</code>',
        'offline',
        '建置中..',
        'storage apps'
      ]
    ]

  # reRender ajax column function
  class cRenderResult
    print: (val) ->
      if val == "online"
        return '<span class="label label-success">上線</span>'
      else if val == "offline"
        return '<span class="label label-error">離線</span>'
      else
        return '<i  class="icon-refresh icon-spin"></i>'
  cRenderResult = new cRenderResult

  # Setting for datatables
  aaSettings =
    aoColumns:
      [
        {bVisible: false, bSortable:true}
        {bSortable: false, sTitle: "實驗室網路服務"}
        {bSortable: false, sTitle: "連線位置"}
        {bSortable: false, sTitle: "認證方式"}
        {
          bSortable: true,
          sTitle: "狀態",
          sClass: "center",
          fnRender: (o, val)->
            cRenderResult.print val
        }
        {bSortable: false, sTitle: "備註"}
        {bVisible: false, bSortable:true}
      ]
    aaData: aaResource
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bSortClasses: false
    bPaginate: false

  # Render datatable
  $('#res_list').html '<table id="res_table"  class="table table-bordered table-striped table-hover table-condensed"></table>'
  oTable = $('#res_table').dataTable aaSettings

  $('#resource').addClass "active"

  # Default show up tab
  hash = window.location.hash.substring 1

  if !hash
    hash = 'all'

  if hash == 'all'
    oTable.fnFilter ''
  else if hash == 'net'
    oTable.fnFilter 'net'
  else if hash == 'host'
    oTable.fnFilter 'host'
  else if hash == 'storage'
    oTable.fnFilter 'storage'
  else if hash == 'apps'
    oTable.fnFilter 'apps'

  $('#filter a[href="#'+hash+'"]').tab 'show'
  $('#filter a[href="#'+hash+'"]').addClass 'active'

  # tab click event
  $('#filter a[href="#all"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter ''

  $('#filter a[href="#net"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter 'net'

  $('#filter a[href="#host"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter 'host'

  $('#filter a[href="#storage"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter 'storage'

  $('#filter a[href="#apps"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter 'apps'