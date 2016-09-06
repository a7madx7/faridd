$(function () {
    $('#search_box')
        .search({
            apiSettings: { url: '/search?term={query}' },
            minCharacters : 3,
            type: 'category'
        })
    ;
}());