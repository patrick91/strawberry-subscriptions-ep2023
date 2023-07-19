select Poll {id, question, description, answers: {id, text, votes}} filter .id = <uuid>$id;
