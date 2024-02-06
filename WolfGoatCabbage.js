function isValidState(state) {
    const [farmer, wolf, goat, cabbage] = state;
    if (wolf === goat && farmer !== wolf) return false;
    if (goat === cabbage && farmer !== goat) return false;
    return true;
}

function getNextStates(currentState) {
    const nextStates = [];
    const [farmer, wolf, goat, cabbage] = currentState;

    for (let i = 0; i < 4; i++) {
        if (i === 0 || currentState[i] === farmer) {
            const newState = [...currentState];
            newState[0] = 1 - farmer; // Перевозимо фермера
            if (i !== 0) {
                newState[i] = 1 - currentState[i]; // Перевозимо об'єкт
            }
            if (isValidState(newState)) {
                nextStates.push(newState);
            }
        }
    }

    return nextStates;
}

function findSolution() {
    const startState = [0, 0, 0, 0]; // Фермер, вовк, коза, капуста
    const goalState = [1, 1, 1, 1]; // Усі на іншому березі
    const visited = new Set();
    const queue = [[startState, []]]; // Стан та шлях до нього

    while (queue.length > 0) {
        const [currentState, path] = queue.shift();
        if (currentState.toString() === goalState.toString()) {
            return [...path, currentState];
        }

        getNextStates(currentState).forEach(nextState => {
            const stateString = nextState.toString();
            if (!visited.has(stateString)) {
                visited.add(stateString);
                queue.push([nextState, [...path, currentState]]);
            }
        });
    }

    return null;
}

// Знаходимо рішення
const solution = findSolution();
console.log(solution);
