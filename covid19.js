addEventListener('load', function() {
  const notice = document.querySelector('aside.notice');
  notice.querySelector('a.close').addEventListener('click', function() {
    notice.remove()
  })
});
