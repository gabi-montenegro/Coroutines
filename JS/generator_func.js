function* genFunc() {
    // (A)
    console.log('First');
    yield;
    console.log('Second');
}

const genObj = genFunc();
for (i in genObj){
    console.log('entrei')

} 
console.log(genObj)
genObj.next();
// Output: First
genObj.next();
// output: Second