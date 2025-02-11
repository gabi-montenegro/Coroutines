function objectEntries(obj) {
    let index = 0;
    let propKeys = Reflect.ownKeys(obj);

    return { //iterador manual com next e done, sem usar function*
        [Symbol.iterator]() {
            return this;
        },
        next() {
            if (index < propKeys.length) {
                let key = propKeys[index];
                index++;
                return { value: [key, obj[key]] };
            } else {
                return { done: true };
            }
        }
    };
}

const jane = { first: 'Jane', last: 'Doe', middle: 'Sarah' };
for(const [key, value] of objectEntries(jane)){ // for-of: simula o next()
    console.log(`${key}: ${value}`);

}