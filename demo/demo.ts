function greet(msg: string) {
    return msg;
}
greet(1);


type Greeting = {
    lang: string
    message: string
}

const greeting: Greeting = {
    lang: "en-us",
    message: "hello",
}

// use this to test autocomplete
greeting.
