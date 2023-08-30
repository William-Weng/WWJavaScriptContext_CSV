function convertCSV(csv) {
    let result = Papa.parse(csv)
    return result.data
}
