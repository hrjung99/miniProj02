// Serialize form data into JSON
const formToSerialize = (formId) => {
    const form = document.querySelector('#' + formId);
    if (!form) {
        console.error('Form not found:', formId);
        return '{}';  // 유효한 JSON 반환
    }

    return JSON.stringify([].reduce.call(form.elements, (data, element) => {
        console.log(element);
        if (element.name === '') return data;

        if (element.type === 'radio' || element.type === 'checkbox') {
            if (!element.checked) return data;

            if (typeof data[element.name] === 'undefined') {
                if (document.querySelector("#" + formId).querySelectorAll("[name='" + element.name + "']").length === 1 || element.type === 'radio') {
                    data[element.name] = element.value;
                } else if (element.type === 'checkbox') {
                    data[element.name] = [element.value];
                }
            } else if (typeof data[element.name] === 'string') {
                data[element.name] = [data[element.name], element.value];
            } else if (Array.isArray(data[element.name])) {
                data[element.name].push(element.value);
            }
        } else {
            data[element.name] = element.value;
        }
        return data;
    }, {}));
};

// Send fetch request with form data or JSON data
const myFetch = (url, formId, handler) => {
    const param = typeof formId === "string" ? formToSerialize(formId) : JSON.stringify(formId);
    const csrf = document.querySelector("meta[name='_csrf']");
    const csrf_header = document.querySelector("meta[name='_csrf_header']");
    const csrfToken = csrf ? csrf.content : null;
    const csrfHeader = csrf_header ? csrf_header.content : null;
    const headers = {"Content-type": "application/json; charset=utf-8"};
    if (csrfToken) {
        headers[csrfHeader] = csrfToken;
    }
    fetch(url, {
        method: "POST",
        body: param,
        headers: headers
    }).then(res => res.json()).then(json => {
        console.log("json ", json);
        if (handler) handler(json);
    });
};

// Activate a menu item
const menuActive = (link_id) => {
    document.querySelector("#" + link_id).classList.add("active");
}

// Print current page pathname
console.log(location.pathname);

// This script can be expanded or modified as needed for the specific functionality required.
