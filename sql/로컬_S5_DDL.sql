--DROP--
DROP TABLE "PRODUCT_IMAGE";
DROP TABLE "PRODUCT";
DROP TABLE "BOARD_FILE";
DROP TABLE "BOARD";
DROP TABLE "BOARD_CATEGORY";
DROP TABLE "MEMBER";

--CREATE--
CREATE TABLE "MEMBER" (
	"MEMBER_ID"	VARCHAR2(30)		NOT NULL,
	"MEMBER_PWD"	VARCHAR2(30)		NOT NULL,
	"MEMBER_NAME"	VARCHAR2(100)		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(80)		NULL,
	"MEMBER_CELLPHONE"	VARCHAR2(12)		NOT NULL,
	"MEMBER_TEL"	VARCHAR2(12)		NULL,
	"MEMBER_ADDRESS_POST"	VARCHAR2(80)	NULL,
	"MEMBER_ADDRESS_1"	VARCHAR2(50)		NOT NULL,
	"MEMBER_ADDRESS_2"	VARCHAR2(50)		NOT NULL
);
ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_ID"
);
COMMENT ON COLUMN "MEMBER"."MEMBER_ID" IS '회원아이디 영문숫자';
COMMENT ON COLUMN "MEMBER"."MEMBER_PWD" IS '회원비밀번호 영문숫자!@^_';
COMMENT ON COLUMN "MEMBER"."MEMBER_NAME" IS '회원명';
COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '@';
COMMENT ON COLUMN "MEMBER"."MEMBER_CELLPHONE" IS '휴대폰번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '전화번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS_POST" IS '우편번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS_1" IS '주소1';
COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS_2" IS '주소2';

--CREATE--
CREATE TABLE "BOARD_CATEGORY" (
	"BOARD_CATEGORY_CODE"	NUMBER(2)		NOT NULL,
	"BOARD_CATEGORY_NAME"	VARCHAR(20)		NOT NULL
);
ALTER TABLE "BOARD_CATEGORY" ADD CONSTRAINT "PK_BOARD_CATEGORY" PRIMARY KEY (
	"BOARD_CATEGORY_CODE"
);
COMMENT ON COLUMN "BOARD_CATEGORY"."BOARD_CATEGORY_CODE" IS '카테고리코드';
COMMENT ON COLUMN "BOARD_CATEGORY"."BOARD_CATEGORY_NAME" IS '1:문의내용, 2:회원/정보관리, 3:주문.결제, 4:배송, 5:반품/환불/교환/AS, 6:영수증/증빙서류, 7:상품/이벤트, 8:기타';

--CREATE--
CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(50)		NOT NULL,
	"BOARD_CONTENT"	CLOB		NOT NULL,
	"BOARD_WRITER"	VARCHAR2(30)		NOT NULL,
	"BOARD_DATE"	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	NOT NULL,
	"BOARD_CATEGORY_CODE"	NUMBER(2)		NOT NULL
);
ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글번호';
COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '문의글제목';
COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '본문내용';
COMMENT ON COLUMN "BOARD"."BOARD_WRITER" IS '작성자';
COMMENT ON COLUMN "BOARD"."BOARD_DATE" IS '작성시간';
COMMENT ON COLUMN "BOARD"."BOARD_CATEGORY_CODE" IS '카테고리코드';

--CREATE--
CREATE TABLE "BOARD_FILE" (
	"BOARD_FILEPATH"	VARCHAR2(500)		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);
ALTER TABLE "BOARD_FILE" ADD CONSTRAINT "PK_BOARD_FILE" PRIMARY KEY (
	"BOARD_FILEPATH",
	"BOARD_NO"
);
COMMENT ON COLUMN "BOARD_FILE"."BOARD_FILEPATH" IS '첨부파일명';
COMMENT ON COLUMN "BOARD_FILE"."BOARD_NO" IS '게시글번호';

--CREATE--
CREATE TABLE "PRODUCT" (
	"PRODUCT_ID"	NUMBER		NOT NULL,
	"PRODUCT_NAME"	VARCHAR(300)		NOT NULL,
	"PRODUCT_PRICE"	NUMBER		NOT NULL,
	"PRODUCT_DETAIL"	CLOB		NOT NULL
);
ALTER TABLE "PRODUCT" ADD CONSTRAINT "PK_PRODUCT" PRIMARY KEY (
	"PRODUCT_ID"
);
COMMENT ON COLUMN "PRODUCT"."PRODUCT_ID" IS '상품ID';
COMMENT ON COLUMN "PRODUCT"."PRODUCT_NAME" IS '상품명';
COMMENT ON COLUMN "PRODUCT"."PRODUCT_PRICE" IS '상품가격';
COMMENT ON COLUMN "PRODUCT"."PRODUCT_DETAIL" IS '상품상세설명';

--CREATE--
CREATE TABLE "PRODUCT_IMAGE" (
	"PRODUCT_IMAGE_CODE"	VARCHAR2(500)		NOT NULL,
	"PRODUCT_CODE"	NUMBER		NOT NULL
);
ALTER TABLE "PRODUCT_IMAGE" ADD CONSTRAINT "PK_PRODUCT_IMAGE" PRIMARY KEY (
	"PRODUCT_IMAGE_CODE"
);
COMMENT ON COLUMN "PRODUCT_IMAGE"."PRODUCT_IMAGE_CODE" IS '상품이미지코드';


--참조키설정--
ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"BOARD_WRITER"
)
REFERENCES "MEMBER" (
	"MEMBER_ID"
);
ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOARD_CATEGORY_TO_BOARD_1" FOREIGN KEY (
	"BOARD_CATEGORY_CODE"
)
REFERENCES "BOARD_CATEGORY" (
	"BOARD_CATEGORY_CODE"
);
ALTER TABLE "BOARD_FILE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_FILE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);
ALTER TABLE "PRODUCT_IMAGE" ADD CONSTRAINT "FK_PRODUCT_TO_PRODUCT_IMAGE_1" FOREIGN KEY (
	"PRODUCT_CODE"
)
REFERENCES "PRODUCT" (
	"PRODUCT_ID"
);

