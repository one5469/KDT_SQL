import pymysql

# 테이블 생성
def createTable(conn, cur):
    try:
        query1 = '''
            create table user_table(
        userID char(8) not null primary key,
        userName varchar(10) not null,
        birthYear int not null,
        addr char(2) not null,
        mobile1 char(3),
        mobile2 char(8),
        height smallint,
        mDate date);
            '''

        query2 = '''create table buy_table(
        num int auto_increment not null primary key,
        userID char(8) not null,
        prodName char(6) not null,
        groupName char(4),
        price int not null,
        amount smallint not null,
        foreign key (userID) references user_table(userID)
                );'''

        cur.execute('drop table if exists user_table')
        cur.execute(query1)
        cur.execute('drop table if exists buy_table')
        cur.execute(query2)
        conn.commit()
        print('Table 생성 완료')
        insertData(conn, cur)
    except:
        print('Table 존재함')

# 데이터 입력
def insertData(conn, cur):
    sql1='''insert into user_table values
('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08');
'''

    sql2='''insert into buy_table values
(1, 'KHD', '운동화', NULL, 30, 2),
(2, 'KHD', '노트북', '전자', 1000, 1),
(3, 'KYM', '모니터', '전자', 200, 1),
(4, 'PSH', '모니터', '전자', 200, 5),
(5, 'KHD', '청바지', '의류', 50, 3),
(6, 'PSH', '메모리', '전자', 80, 10),
(7, 'KJD', '책', '서적', 15, 5),
(8, 'LHJ', '책', '서적', 15, 2),
(9, 'LHJ', '청바지', '의류', 50, 1),
(10, 'PSH', '운동화', NULL, 30, 2),
(11, 'LHJ', '책', '서적', 15, 1),
(12, 'PSH', '운동화', NULL, 30, 2);
'''

    cur.execute(sql1)
    cur.execute(sql2)
    conn.commit()
    print('데이터 입력 완료')

# 내부 조인한 결과에 '연락처' 컬럼 추가
def addPhoneNum(conn, cur):
    sql = '''
    select userName, prodName, addr, concat(mobile1, mobile2) as 연락처
from buy_table inner join user_table
on buy_table.userID = user_table.userID
order by user_table.userID asc
;'''

    cur.execute(sql)
    print('문제 1번')
    print('-------------------------------------------')
    print('userName prodName  addr     연락처')
    print('-------------------------------------------')
    rows = cur.fetchall()
    for row in rows:
        print(row)

# userID가 KYM인 사람이 구매한 물건과 회원 정보 출력
def printKYM(conn, cur):
    sql = '''
        select u.userID, userName, prodName, addr, 
concat(u.mobile1, u.mobile2) as 연락처
from buy_table as b inner join user_table as u
on b.userID = u.userID where u.userID = 'KYM';'''

    cur.execute(sql)
    print('문제 2번')
    print('-------------------------------------------')
    print('userID userName prodName  addr     연락처')
    print('-------------------------------------------')
    rows = cur.fetchall()
    for row in rows:
        print(row)

# 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
def allPur(conn, cur):
    sql = '''
        select u.userID, userName, prodName, addr, 
concat(u.mobile1, u.mobile2) as 연락처
from buy_table as b inner join user_table as u
on b.userID = u.userID
order by userID asc;'''

    cur.execute(sql)
    print('문제 3번')
    print('-------------------------------------------')
    print('userID userName prodName  addr     연락처')
    print('-------------------------------------------')
    rows = cur.fetchall()
    for row in rows:
        print(row)

# 쇼핑물에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력
def buyedUser(conn, cur):
    sql = '''
        select distinct u.userID, userName, addr
from buy_table as b inner join user_table as u
on b.userID = u.userID
order by userID asc;'''

    cur.execute(sql)
    print('문제 4번')
    print('-------------------------------------------')
    print('userID  userName addr')
    print('-------------------------------------------')
    rows = cur.fetchall()
    for row in rows:
        print(row)

# 쇼핑물 회원 중에서 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력
def printGyung(conn, cur):
    sql = '''
        select u.userID, u.userName, addr,
concat(u.mobile1, u.mobile2) as 연락처
from buy_table as b inner join user_table as u
on b.userID = u.userID
where (addr = '경북') or (addr = '경남')
order by userID asc;'''

    cur.execute(sql)
    print('문제 5번')
    print('-------------------------------------------')
    print('userID  userName addr   연락처')
    print('-------------------------------------------')
    rows = cur.fetchall()
    for row in rows:
        print(row)

def main():
    conn = pymysql.connect(host='localhost', user='root', password='root',
                           db='shoppingmall', charset='utf8')

    curs = conn.cursor()

    createTable(conn, curs)
    addPhoneNum(conn, curs)
    print()
    printKYM(conn, curs)
    print()
    allPur(conn, curs)
    print()
    buyedUser(conn, curs)
    print()
    printGyung(conn, curs)

    curs.close()
    conn.close()

main()