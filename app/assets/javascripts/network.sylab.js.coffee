# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  dn = 'sylab.csie.tk'
  aaIps = []

  # Prepare ip list
  for i in [1..254] by 1
    ip = '192.168.67.' + i
    if i < 30
      item = [ i, ip, 'loading', 'loading', 'loading', 'loading','--', '--', '--', '--']
    else
      item = [ i, ip, 'loading', 'loading', 'loading', 'loading',
              dn+':33'+i, dn+':22'+i, dn+':20'+i, dn+':21'+i ]

    aaIps.push item

  # reRender ajax column function
  class cRenderResult
    print: (val) ->
      if val == "online"
        return '<span class="label label-success">上線</span>'
      else if val == "offline"
        return '<span class="label label-error">離線</span>'
      else if val == "loading"
        return '<i  class="icon-refresh icon-spin"></i>'
      else
        return val
  cRenderResult = new cRenderResult

  # Setting for datatables
  aaSettings =
    aoColumns:
      [
        {bVisible: false}
        {
          bSortable: true,
          sTitle: "IP"
        }
        {
          bSortable: true,
          sTitle: "名稱",
          fnRender: (o, val)->
            cRenderResult.print val
        }
        {
          bSortable: false,
          sTitle: "網卡",
          fnRender: (o, val)->
            cRenderResult.print val
        }
        {
          bSortable: true,
          sTitle: "Ping",
          fnRender: (o, val)->
            cRenderResult.print val
        }
        {
          bSortable: false,
          sTitle: "狀態",
          sClass: "center",
          fnRender: (o, val)->
            cRenderResult.print val
        }
        {bSortable: false, sClass: "center", sTitle: "校外連入遠端桌面"}
        {bSortable: false, sClass: "center", sTitle: "校外連入SSH"}
        {bSortable: false, sClass: "center", sTitle: "校外連入網站"}
        {bSortable: false, sClass: "center", sTitle: "校外連入FTP"}
      ]
    aaData: aaIps
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bSortClasses: false
    bPaginate: true,
    iDisplayLength: 20

  # Render datatable
  $('#ip_list').html '<table id="ip_table"  class="table table-bordered table-striped table-hover table-condensed"></table>'
  oTable = $('#ip_table').dataTable aaSettings

  # Query Status from nmap api
  for j in [0..254] by 1
    do (j) ->
      setTimeout (()->
        ip = '192.168.67.' + (j+1)
        setTimeout ()->
          $.getJSON 'http://service.sylab.ee.ntu.edu.tw/network/scan/'+ip,(data)->
            row = data.ip.split('.')
            oTable.fnUpdate data.hostname, row[3]-1, 2
            oTable.fnUpdate data.mac, row[3]-1, 3
            oTable.fnUpdate data.ping, row[3]-1, 4
            oTable.fnUpdate data.status, row[3]-1, 5
      ), j*4500

  #oTable.fnUpdate "offline", j, 5

  $('#network').addClass 'active'

  # Default show up tab
  hash = window.location.hash.substring 1

  if !hash
    hash = 'pc-offline'

  if hash == 'pc-offline'
    oTable.fnFilter '離線 LabPC'
  else if hash == 'pc-online'
    oTable.fnFilter '上線 LabPC'
  else if hash == 'service'
    oTable.fnFilter '--'
  else if hash == 'vpn'
    oTable.fnFilter 'LabVPN'
  else if hash == 'all'
    oTable.fnFilter ''

  $('#filter a[href="#'+hash+'"]').tab 'show'
  $('#filter a[href="#'+hash+'"]').addClass 'active'

  # tab click event
  $('#filter a[href="#all"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter ''

  $('#filter a[href="#pc-offline"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter '離線 LabPC'

  $('#filter a[href="#pc-online"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter '上線 LabPC'

  $('#filter a[href="#service"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter '--'

  $('#filter a[href="#vpn"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter 'LabVPN'

  # new FixedHeader oTable