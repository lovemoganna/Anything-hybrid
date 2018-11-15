export default (text = 'Hello Purecss!') => {
  const element = document.createElement('div');
  element.className = 'pure-button';
  element.innerHTML = text;
  // 通过动态导入,然后promise的风格来拆分代码
  element.onclick = () =>
        import('./lazy')
            .then((lazy) => {
              element.textContent = lazy.default;
            })
            .catch((err) => {
              console.error(err);
            });
  return element;
};

