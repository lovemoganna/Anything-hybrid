export default (text ='Hello Purecss!') => {
  const element = document.createElement('div');
  element.className = 'pure-button';
  element.innerHTML = text;
  return element;
};
