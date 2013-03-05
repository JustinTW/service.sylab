# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery(document).ready(
  ->
    dn = 'sylab.csie.tk'
    aaIps = []

    # Prepare ip list
    for i in [1..254] by 1
      ip = '192.168.67.' + i
      if i < 10
        item = [ i, ip, 'loading', 'loading', 'loading', 'loading','-', '-', '-', '-']
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
        else
          return '<i  class="icon-refresh icon-spin"></i>'
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
          {bSortable: false, sTitle: "校外連入遠端桌面"}
          {bSortable: false, sTitle: "校外連入SSH"}
          {bSortable: false, sTitle: "校外連入網站"}
          {bSortable: false, sTitle: "校外連入FTP"}
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
    #for j in [0..253] by 1
      #setTimeout ()->
      #oTable.fnUpdate "offline", j, 5
      #, 3000


    $('#network').addClass 'active'

    # Default show up tab
    hash = window.location.hash.substring 1
    if hash == 'offline'
      oTable.fnFilter '離線'
      $('#filter a[href="#'+hash+'"]').tab 'show'
      $('#filter a[href="#'+hash+'"]').addClass 'active'
    else if hash == 'online'
      oTable.fnFilter '上線'
      $('#filter a[href="#'+hash+'"]').tab 'show'
      $('#filter a[href="#'+hash+'"]').addClass 'active'
    else
      $('#filter a[href="#all"]').addClass 'active'
      oTable.fnFilter ''

    # tab click event
    $('#filter a[href="#all"]').click(
      (e)->
        e.preventDefault();
        $(this).tab('show');
        oTable.fnFilter ''
    )
    $('#filter a[href="#offline"]').click(
      (e)->
        e.preventDefault();
        $(this).tab('show');
        oTable.fnFilter '離線'
    )
    $('#filter a[href="#online"]').click(
      (e)->
        e.preventDefault();
        $(this).tab('show');
        oTable.fnFilter '上線'
    )

    # new FixedHeader oTable
);