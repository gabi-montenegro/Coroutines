function* task() {
    let received = yield "Task started";
    console.log(`Received: ${received}`);
    received = yield "Task in progress";
    console.log(`Received: ${received}`);
    return "Task completed";
}

// Controlador da tarefa
const t = task();

console.log(t.next().value); // Output: "Task started"
// console.log(t.next("First input").value); // Output: Received: First input
//                                           //         Task in progress
// console.log(t.next("Second input").value); // Output: Received: Second input
//                                           //         Task completed
