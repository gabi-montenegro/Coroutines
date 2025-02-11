const co = require('co');

const fetchJson = co.wrap(function* (url) {
    try {
        let request = yield fetch(url);
        let text = yield request.text();
        return JSON.parse(text);
    }
    catch (error) {
        console.log(`ERROR: ${error.stack}`);
    }
});

fetchJson('http://example.com/some_file.json')
.then(obj => console.log(obj));