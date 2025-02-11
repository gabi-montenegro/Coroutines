function* task1() {
    console.log("Task 1: Start");
    yield; // Pausa e permite outra tarefa executar
    console.log("Task 1: Resume");
}

function* task2() {
    console.log("Task 2: Start");
    yield; // Pausa e permite outra tarefa executar
    console.log("Task 2: Resume");
}

// Controlador de multitarefa
function runTasks(tasks) {
    let i = 0;
    while (tasks.some(t => !t.done)) {
        const task = tasks[i % tasks.length];
        task.done = task.generator.next().done;
        i++;
    }
}

const tasks = [
    { generator: task1(), done: false },
    { generator: task2(), done: false }
];

runTasks(tasks);
// Output:
// Task 1: Start
// Task 2: Start
// Task 1: Resume
// Task 2: Resume
