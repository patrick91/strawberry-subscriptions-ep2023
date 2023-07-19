update Answer
filter .id = <uuid>$id
set {
    votes := .votes + 1
}
