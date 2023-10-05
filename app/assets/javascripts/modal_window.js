$(function() {

  // #modal-openがクリックされたらモーダルウィンドウを表示
  $("#modal-open").on('click',function(){
      $("#modal-overlay").fadeIn("fast"); // モーダルウィンドウを表示
  });

  // キャンセルボタンかオーバーレイ部をクリックでモーダルウィンドウを閉じる
  $("#modal-close,#modal-overlay").on('click',function(){
    $("#modal-overlay").fadeOut("fast"); // モーダルウィンドウを非表示
  });

});
