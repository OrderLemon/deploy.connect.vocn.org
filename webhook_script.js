class Script {
    /**
     * @params {object} request
     */
    process_incoming_request({ request }) {
        // request.url.hash
        // request.url.search
        // request.url.query
        // request.url.pathname
        // request.url.path
        // request.url_raw
        // request.url_params
        // request.headers
        // request.user._id
        // request.user.name
        // request.user.username
        // request.content_raw
        // request.content

        // console is a global helper to improve debug
        console.log(request.content);
        const patient = request.content.PatientsName.split(",").reverse().join(" ")
        const url = request.content.ReportOriginalUrl
        const stat = request.content.StatRequest
        const species = request.content.PatientSpeciesDescription
        const images = request.content.NumberOfStudyRelatedInstances
        const modality = request.content.ModalitiesInStudy

        let prio_text = ''
        switch (stat) {
            case "0":
            case "00":
            case 0:
                break;
            case "10":
            case 10:
                prio_text = "12hr"
                break;
            case "20":
            case 20:
                prio_text = "1hr"
                break;
            case "30":
            case 30:
                prio_text = "2hr"
                break;
            default:
                prio_text = "Undefined priority"
        }
        if (prio_text === '') {
            return
        } else {
            return {
                content: {
                    text: `${prio_text} \`${modality}\` STAT requested for ${patient}${species ? "(" + species + ")" : ""} \n [Click here to view the images(${images})](${url})`,

                }
            }
        }
    }
}
