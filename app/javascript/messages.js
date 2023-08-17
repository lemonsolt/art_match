import $ from 'jquery';

// DMのjavascript（ページ下部の表示）
$(document).on('turbolinks:load', function() {
  // ページ読み込み時に一番下までスクロール
  scrollToBottom();

  // 新しいメッセージが追加された際にスクロール
  $('.new-message').on('ajax:create', function() {
    scrollToBottom();
  });
});

function scrollToBottom() {
  var chatContainer = $('.dm_messages');
  chatContainer.scrollTop(chatContainer.prop('scrollHeight'));
}