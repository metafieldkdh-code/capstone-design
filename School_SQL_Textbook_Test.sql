-- 질의 3-34
-- 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 정수형은 INTEGER를 사용하며 문자형은 가변형 문자 타입인 VARCHAR을 사용한다.
-- bookid(도서번호) - INTEGER
-- bookname(도서이름) - VARCHAR(20)
-- publisher(출판사) - VARCHAR(20)
-- price(가격) - INTEGER
create table NewBook (
	bookid	INTEGER,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER
);

drop table if exists NewBook;

-- bookname은 NULL 값을 가질 수 없고, publisher에는 같은 값이 있으면 안 된다. price에 값이 입력되지 않을 경우 기본값 10000을 저장한다. 또 가격은 최소 1,000원 이상으로 한다.
create table NewBook (
		bookname INTEGER NOT NULL,
        publisher VARCHAR(20) UNIQUE,
        price INTEGER DEFAULT 10000 CHECK(price >= 1000),
        PRIMARY KEY (bookname, publisher)
);

-- 질의 3-35
-- 다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
-- custid(고객번호) - INTEGER, 기본키
-- name(이름) - VARCHAR(40)
-- address(주소) - VARCHAR(40)
-- phone(전화번호) - VARCHAR(30)

create table NewCustomer (
	custid INTEGER,
    name VARCHAR(40),
    address VARCHAR(40),
    phone VARCHAR(40),
    PRIMARY KEY (custid));

CREATE TABLE NewCustomer (
	custid	INTEGER PRIMARY KEY,
    name	VARCHAR(40),
    address VARCHAR(40),
    phone	VARCHAR(30));
    
DROP TABLE IF EXISTS NewCustomer;

-- 질의 3-36
-- 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
-- orderid(주문번호) - INTEGER, 기본키
-- custid(고객번호) - INTEGER, NOT NULL 제약조건, 외래키(NewCustomer, custid, 연쇄 삭제)
-- bookid(도서번호) - INTEGER, NOT NULL 제약조건
-- saleprice(판매가격) - INTEGER
-- orderdate(판매일자) - DATE
CREATE TABLE NewOrders (
	orderid INTEGER,
	custid INTEGER NOT NULL,
    bookid INTEGER NOT NULL,
    salepirce INTEGER,
    orderdate DATE,
	primary key(orderid),
    FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
);     
    