import pymysql

def create_table(conn, cur):
    try:
        query = '''
            create table customer2
            (name varchar(10),
            category smallint,
            region varchar(10))
            '''

        cur.execute(query)
        conn.commit()
        print('Table 생성 완료')

    except Exception as e:
        print(e)

def main():
    conn = pymysql.connect(host='localhost', user='root', password='root',
                           db='sqlclass_db', charset='utf8')

    cur = conn.cursor()

    create_table(conn, cur)

    cur.close()
    conn.close()
    print('Database 연결 종료')

main()