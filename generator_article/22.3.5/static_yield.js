function* genFunc() {
    ['a', 'b'].forEach(x => yield x); 
}
// function* genFunc() {
//     for (const x of ['a', 'b']) {
//         yield x; 
//     }
// }


const genObj = genFunc();
console.log(genObj.next()); // {value: "a", done: false}
console.log(genObj.next()); // {value: "b", done: false}
console.log(genObj.next()); // {value: undefined, done: true}