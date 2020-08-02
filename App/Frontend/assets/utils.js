function predictWeight() {
    let height = system.person_controller.person.height
    let gender = system.person_controller.person.gender
    let acc = gender === "male" ? 50 : 45.5
    return parseNumber(acc + 0.91 * (height - 152.4))
}

function parseNumber(number) {
    if (!parseFloat(number) && isNaN(number)) {
        return "-"
    }
    if (parseInt(number) === parseFloat(number)) {
        return parseInt(number)
    } else {
        return parseFloat(number).toFixed(1)
    }
}