function* processStream(stream) {
    for (const chunk of stream) {
        yield `Processing chunk: ${chunk}`;
    }
}

const stream = ["data1", "data2", "data3"];
const processor = processStream(stream);

console.log(processor.next().value); // Processing chunk: data1
console.log(processor.next().value); // Processing chunk: data2
console.log(processor.next().value); // Processing chunk: data3
