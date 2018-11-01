
export default (text = "hello webpack") => {
    const element = document.createElement("div");
    element.innerHTML = text ;
    return element;
}
