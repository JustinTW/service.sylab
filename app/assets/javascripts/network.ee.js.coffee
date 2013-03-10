# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  dn = 'sylab.csie.tk'
  aaIps = []

  # Prepare ip list
  for i in [1..254] by 1
    ip = '140.112.42.' + i
    item = [ i, ip, '-', '-', '-', 'loading']

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
      else if val == "[]"
        return "-"
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
          sTitle: "品牌",
          fnRender: (o, val)->
            cRenderResult.print val
        }
        {
          bSortable: true,
          sTitle: "狀態",
          sClass: "center",
          fnRender: (o, val)->
            cRenderResult.print val
        }
      ]
    aaData: aaIps
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bSortClasses: false
    bPaginate: true,
    iDisplayLength: 20,
    bProcessing: true

  # Render datatable
  $('#ip_list').html '<table id="ip_table"  class="table table-bordered table-striped table-hover table-condensed"></table>'
  oTable = $('#ip_table').dataTable aaSettings

  #Query Status from nmap api

  ip = '140.112.42.0'
  $.getJSON 'http://service.sylab.ee.ntu.edu.tw/network/scan/'+ip
    ,(data)->
      key = []

      for j in [0..data.length-1] by 1
        row = data[j].ip.split('.')
        key.push row[3]-1
        oTable.fnUpdate data[j].hostname, row[3]-1, 2
        oTable.fnUpdate data[j].mac, row[3]-1, 3
        oTable.fnUpdate data[j].brand, row[3]-1, 4
        oTable.fnUpdate data[j].status, row[3]-1, 5

      for k in [0..253] by 1
        unless k in key
          oTable.fnUpdate 'offline', k, 5

      $('#loading').hide()

  $('#network').addClass 'active'

  # Default show up tab
  hash = window.location.hash.substring 1

  if !hash
    hash = 'all'

  if hash == 'pc-offline'
    oTable.fnFilter '離線'
  else if hash == 'pc-online'
    oTable.fnFilter '上線'
  else if hash == 'service'
    oTable.fnFilter '--'
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
      oTable.fnFilter '離線'

  $('#filter a[href="#pc-online"]').click (e)->
      #e.preventDefault
      $(this).tab 'show'
      oTable.fnFilter '上線'



  # new FixedHeader oTable