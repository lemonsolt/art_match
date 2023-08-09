// トップへのスクロール
$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 600);
    event.preventDefault();
  });
});

$(function(){
  $('#back a').mouseover(function(){
    $('#back a').css({'color': '#b0c4de'});
  });
});

// ハンバーガーメニュー
$(".openbtn1").on('click',function () {//ボタンがクリックされたら
  $(this).toggleClass('active');//ボタン自身に activeクラスを付与し
    $("#g-nav_list").fadeToggle();
    event.preventDefault();
});

$("#g-nav a").on('click',function () {//ナビゲーションのリンクがクリックされたら
    $(".openbtn1").removeClass('active');//ボタンの activeクラスを除去し
    $("#g-nav").removeClass('panelactive');//ナビゲーションのpanelactiveクラスも除去
});