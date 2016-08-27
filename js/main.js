import Elm from '../elm/Main'

const app = Elm.Main.fullscreen()

// Sets up a simple dispatch/respond (aka pub/sub) port for
// inter-communication between elm modules
// Defined in Ports/Events.elm
app.ports.dispatch.subscribe((msg) => {
    app.ports.respond.send(msg)
});
