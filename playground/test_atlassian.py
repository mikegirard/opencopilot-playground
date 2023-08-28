from atlassian import Confluence

def get_atlassian_page_content():
    confluence = Confluence(
        url='https://ninjacat.atlassian.net/wiki',
        username="michael@ninjacat.io",
        password="ATATT3xFfGF0CaxZk4OcchxEfIwkl1N_CCzgLx7se57li2_Y7v9pifHt9u7IvpcTLc1xqk1KlEgtZZCeCOeHYHjyWgGHgoCEK8uxZoJDbHWarbkvY9rq2e6y53hDxuf2G7_DKffh4awDpzlkZW2e5EJyJu-nYb5RzTBPt08k1oESt7bl2BR_V1E=5FDCEB15"
    )

    page_id = confluence.get_page_id(space='SHIN', title='Engineering Teams')
    page_content = confluence.get_page_by_id(page_id, expand='body.storage')
    
    return page_content['body']['storage']['value']

print(get_atlassian_page_content())