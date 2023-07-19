with new_poll := (
    insert Poll {
        question := <str>$question,
        description := <optional str>$description,
        answers := (
            for answer in json_array_unpack(<json>$answers)
            union (
                insert Answer {
                    text := <str>answer,
                }
            )
        )
    }
)

select new_poll {id, question, description, answers: {id, text, votes}}
