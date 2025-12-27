# JQ

Make sure to checkout [the full documentation](https://jqlang.org/).

## Select

```bash
$ jq '.name' file.json
$ cat file.json | jq '.a.b[0].c'
# from top level
$ cat file.json | jq '. | {field1, field2}'
# from sub level
$ cat file.json | jq '.results[] | {id, name}'
```

## Slicing

```bash
echo '["a", "b", "c", "d"]' | jq '.[1:3]'
# ["b", "c"]
echo '["a", "b", "c", "d"]' | jq '.[1:]'
# ["b", "c", "d"]
```

## Functions

```bash
echo '{ "a": 1, "b": 2 }' | jq 'keys'
# [a, b]
echo '[0, 1, 1, 2, 3, 5, 8]' | jq 'length'
# 7
echo '[1, 2, [3, 4]]' | jq 'flatten'
# [1, 2, 3, 4]
echo '[1, 2, 2, 3]' | jq 'unique'
# [1, 2, 3]
echo '"YWRtaW4="' | jq -r '. | @base64d'
# admin
```

## Filter

```bash
# get "name" of id 1
$ cat file.json | jq '.results[] | select(.id == "1") | {name}'
# get result with multiple filters
$ cat file.json | jq '.results[] | select((.id == "1") and (.name="a"))'
# filter with substrings
$ cat file.json | jq '.results[] | select(.name | contains("ab"))'
# filter with regex
$ cat file.json | jq '.results[] | select(.name | test("Joe\s+Smith"))'
```

## Replace

```bash
cat file.json | jq '(.items[] | select(.spec.foo == "key")).spec.bar |= "baz"'
```

## Examples

```bash
echo '{ "firstName": "Cameron", "lastName": "Nokes" }' | jq '[.firstName, .lastName] | join(" ")'
# Cameron Nokes
```

## Working with files

`jq` can load queries from files with `-f`, and data file(s) as argument(s):

```bash
jq -f query.jq data.json
jq -f query.jq data.json data2.json
jq -f query.jq < data.json
```

## Credit

- https://cameronnokes.com/blog/jq-cheatsheet/
- https://www.hackingnote.com/en/cheatsheets/jq/
