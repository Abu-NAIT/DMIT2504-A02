// we'll store all our routes in a separate place
// nothing stops us from storing our route mapping somewhere like here,
// a dedicated / cleaner place, instead of straight app

const homeRoute = '/';
const nestedPathRoute = '/nested_path';
// I've made sure to give this a unique name (i.e. not reuse nestedPathHome from the nested_path/routes.dart).
// This isn't crucial in this example, BUT it means anytime later, I can import routes directly without risking a name clash.