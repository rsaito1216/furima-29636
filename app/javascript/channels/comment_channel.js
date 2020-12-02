import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
  
  received(data) {
    const text = `<p>${data.content.text}</p>`;
    const createdAt = `<p>${data.content.created_at}</p>`;
    const nickName = `<p>${data.user.nickname}</p>`;
    const HTML = `
    <div class="comment-all">
      <div class="upper-comment">
        <div class="comment-name">
          <p>${nickName}</p>
        </div>

        <p class="word">さん</p>
      
        <div class="created-at">
          <p>${createdAt}</p>
        </div>
      </div>
        <div class="comment-textzone">
          <p>${text}</p>
        </div>
     </div>
    `
    const comments = document.getElementById('comment_list');
    comments.insertAdjacentHTML('afterbegin', HTML);
    const newComment = document.getElementById('comment_text');
    newComment.value='';
  }
});