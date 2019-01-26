show user;
-- #������Ʈ ����
-- [190106] �������� ������, �������ȯ�� ���� ���̺� �� ������
-- [190107] 1; ���� ���� ����
-- [190107] 2; ���ȸ���� ���̺��� Ư�̻����� ���� ã�ƿ��±� �÷� �߰�
-- [190111] member , biz_info �÷� �߰� (�̹��� ���ϸ�), �������Ǹ� ����; ����
-- [190114] ȸ�� ��� ����(fk�÷�, ���̺�); ȸ�� ���
-- [190118] consult ���̺�, consult_comment ���̺� �÷��߰� �� ����; ����
-- [190120] reservation ���̺� fk_idx_biz �÷� �� fk �������� �߰�; ����
-- [190122] pet_info ���̺� pet_size, pet_weight �÷� not null ����, pet_status �÷� �߰�; ����
-- [190122] notification ���̺� not_type �÷� check���� ���� ����; ȣȯ
-- [190124] 1; deposit ���̺� fk_payment_UID �÷� �߰�; ����
-- [190124] 2; notification ���̺� �÷� �� �������� �߰� : ����
-- [190125] ���ν��� where�� �߰�; ����
-- [190126] ����ȸ�� ���� ���� ������ ���� ���ν��� �߰�; ����
------------------------------------------------------------------------------
-- ���� ��ȸ
show user;

-- ��� ���̺� ��ȸ
select * from user_tables;

-- ��� ������ ��ȸ
select * from user_sequences;

-- ��� �������� ��ȸ
select * from user_constraints;

-- ���̺� ���� ��ɹ�
drop table schedule purge;
drop table reservation purge;
drop table payment purge;
drop table deposit purge;
drop table refund purge;
drop table withdraw purge;
drop table dep_use purge;

-- ������ ���� ��ɹ�
drop sequence seq_schedule_schedule_UID;
drop sequence SEQ_RESERVATION_RESERV_UID;
drop sequence seq_payment_schedule_UID;
drop sequence seq_deposit_deposit_UID;
drop sequence seq_refund_refund_UID;
drop sequence seq_withdraw_withdraw_UID;
drop sequence seq_dep_use_dep_use_UID;

-------------------------------------------------------------------------------
CREATE TABLE member_level (
   level_UID      NUMBER   NOT NULL, -- ��޹�ȣ
   level_name     VARCHAR2(20) NOT NULL, -- ��޸�
   level_limit    NUMBER   NOT NULL, -- �������
   level_contents VARCHAR2(100) NOT NULL  -- ��޼���
    
    ,CONSTRAINT PK_level PRIMARY KEY (level_UID)
);

drop table member_level purge;

-- ȸ��
CREATE TABLE member (
   idx          NUMBER    NOT NULL, -- ȸ��������ȣ
   userid       VARCHAR2(255)  NOT NULL, -- �̸��Ͼ��̵�
   pwd          VARCHAR2(100)  NOT NULL, -- ��й�ȣ
   name         VARCHAR2(100)  NOT NULL, -- �̸�
   nickname     VARCHAR2(100)  NOT NULL, -- �г���
   birthday     VARCHAR2(50)  NOT NULL, -- �������
   gender       NUMBER(1) default 1 NOT NULL, -- ����
   phone        VARCHAR2(100)  NOT NULL, -- ����ó
   profileimg   VARCHAR2(100)  NOT NULL, -- �����ʻ���
   membertype   NUMBER(1) NOT NULL, -- ȸ��Ÿ��
   point        NUMBER    default 0 NOT NULL, -- ����Ʈ
   totaldeposit NUMBER    default 0 NOT NULL, -- ������ġ��
   noshow       NUMBER    default 0 NOT NULL, -- �������
   registerdate DATE      default sysdate NOT NULL  -- ��������
    
    , CONSTRAINT PK_member PRIMARY KEY (idx) -- ȸ�� �⺻Ű
    , CONSTRAINT uq_member_userid UNIQUE (userid) -- ȸ�����̵�UQ   
    , CONSTRAINT ck_member_gender check(gender in(1,2)) -- ȸ������ üũ����   
    , CONSTRAINT ck_member_memtype check(membertype in(1, 2, 3)) -- ȸ��Ÿ�� üũ����
);

alter table member
add fileName   VARCHAR2(100)  NOT NULL;

-- ��޹�ȣ ����
ALTER TABLE member DROP COLUMN fk_level_UID;



CREATE TABLE login_log (
   idx           NUMBER   NOT NULL, -- ȸ��������ȣ
   fk_userid     VARCHAR2(255) NOT NULL, -- �̸��Ͼ��̵�
   fk_pwd        VARCHAR2(100) NOT NULL, -- ��й�ȣ
   lastlogindate DATE     NOT NULL, -- �α����Ͻ�
   member_status NUMBER(1)   default 1 NOT NULL  -- ȸ������ Ȱ��1 �޸�0
    
    , CONSTRAINT PK_login_log PRIMARY KEY (idx) -- �α��� �⺻Ű
    , CONSTRAINT CK_login_log_status check(member_status in(0,1)) -- ȸ������ üũ����
    , CONSTRAINT FK_member_TO_login_log FOREIGN KEY (idx) REFERENCES member (idx)
);



-- ȸ�� ������
-- drop sequence seq_member;
create sequence seq_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

        
-- ���ȸ����
CREATE TABLE biz_info (
   idx_biz    NUMBER    NOT NULL, -- ����/�౹������ȣ
   biztype    NUMBER(1) NOT NULL, -- �������
   repname    VARCHAR2(50)  NOT NULL, -- ��ǥ�ڸ�
   biznumber  VARCHAR2(100)  NOT NULL, -- ����ڹ�ȣ
   postcode   VARCHAR2(10)  NOT NULL, -- �����ȣ
   addr1      VARCHAR2(100)  NOT NULL, -- �ּ�
   addr2      VARCHAR2(100)  NOT NULL, -- �ּ�2
   latitude   VARCHAR2(100)  NOT NULL, -- ����
   longitude  VARCHAR2(100)  NOT NULL, -- �浵
   prontimg   VARCHAR2(100)  NOT NULL, -- ��ǥ�̹���
   weekday    VARCHAR2(100)  NOT NULL, -- ����; ��~��(�� 5), ȭ~��(�� 4), ��, ��, ��(�� 3)
   wdstart    DATE      NOT NULL, -- ���Ͻ��۽ð�
   wdend      DATE      NOT NULL, -- ��������ð�
   lunchstart DATE      NOT NULL, -- ���ɽ��۽ð�
   lunchend   DATE      NOT NULL, -- ��������ð�
   satstart  DATE      NOT NULL, -- ����Ͻ���
   satend     DATE      NOT NULL, -- ���������
   dayoff     VARCHAR2(100)  NOT NULL, -- �Ͽ���/������
   dog        NUMBER(1) NOT NULL, -- ������
   cat        NUMBER(1) NOT NULL, -- �����
   smallani   NUMBER(1) NOT NULL, -- �ҵ���
   etc        NUMBER(1) NOT NULL, -- ��Ÿ
   easyway  VARCHAR2(255)  NULL,     -- ã�ƿ��±�
   intro      CLOB      NOT NULL  -- �Ұ���
    ,CONSTRAINT PK_biz_info -- ���ȸ���� �⺻Ű
      PRIMARY KEY (
         idx_biz -- ����/�౹������ȣ
      )
    ,CONSTRAINT UK_biz_info -- ���ȸ���� ����ũ ����
      UNIQUE (
         biznumber -- ����ڹ�ȣ
      )
    ,CONSTRAINT ck_biz_info_dog -- ������ üũ����
      check(dog in(1,0))
    ,CONSTRAINT ck_biz_info_cat -- ����� üũ����
      check(cat in(1,0))
    ,CONSTRAINT ck_biz_info_smallani -- �ҵ��� üũ����
      check(smallani in(1,0))
    ,CONSTRAINT ck_biz_info_etc -- ��Ÿ üũ����
      check(etc in(1,0))
    ,CONSTRAINT FK_member_TO_biz_info -- ȸ�� -> ���ȸ����
      FOREIGN KEY (
         idx_biz -- ����/�౹������ȣ
      )
      REFERENCES member ( -- ȸ��
         idx -- ȸ��������ȣ
      )
);


-- ���ȸ���߰��̹���
CREATE TABLE biz_info_img (
   img_UID     NUMBER   NOT NULL, -- �̹���������ȣ
   fk_idx_biz  NUMBER   NOT NULL, -- ����/�౹������ȣ
   imgfilename VARCHAR2(100) NOT NULL  -- �̹������ϸ�
    ,CONSTRAINT PK_biz_info_img -- ���ȸ���߰��̹��� �⺻Ű
      PRIMARY KEY (
         img_UID -- �̹���������ȣ
      )
);
ALTER TABLE biz_info_img
   ADD
      CONSTRAINT FK_biz_info_TO_biz_info_img -- ���ȸ���� -> ���ȸ���߰��̹���
      FOREIGN KEY (
         fk_idx_biz -- ����/�౹������ȣ
      )
      REFERENCES biz_info ( -- ���ȸ����
         idx_biz -- ����/�౹������ȣ
      );


create sequence biz_info_img_seq --������� �̹��� 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �Ƿ���
CREATE TABLE doctors (
	doc_UID    NUMBER    NOT NULL, -- �Ƿ���������ȣ
	fk_idx_biz NUMBER    NOT NULL, -- ����/�౹������ȣ
	docname    VARCHAR2(100)  NOT NULL, -- �Ƿ�����
	dog        NUMBER(1) NOT NULL, -- ������
	cat        NUMBER(1) NOT NULL, -- �����
	smallani   NUMBER(1) NOT NULL, -- �ҵ���
	etc        NUMBER(1) NOT NULL  -- ��Ÿ
    ,CONSTRAINT PK_doctors -- �Ƿ��� �⺻Ű
		PRIMARY KEY (
			doc_UID -- �Ƿ���������ȣ
		)
     ,CONSTRAINT ck_doctors_dog -- ������ üũ����
		check(dog in(1,0))
    ,CONSTRAINT ck_doctors_cat -- ����� üũ����
		check(cat in(1,0))
    ,CONSTRAINT ck_doctors_smallani -- �ҵ��� üũ����
		check(smallani in(1,0))
    ,CONSTRAINT ck_doctors_etc -- ��Ÿ üũ����
		check(etc in(1,0))
);

create sequence seq_doctors_UID --�Ƿ��� 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �±� ���̺�
--drop table recommend_tag purge;
CREATE TABLE recommend_tag (
   tag_UID  NUMBER   NOT NULL, -- �±׹�ȣ
   tag_type VARCHAR2(100) NOT NULL, -- �о�
   tag_name VARCHAR2(100) NOT NULL  -- �±��̸�
    ,CONSTRAINT PK_recommend_tag PRIMARY KEY(tag_UID)
);

ALTER TABLE recommend_tag 
ADD CONSTRAINT UQ_recommend_tag_name UNIQUE(tag_name);

-- �±� ������
create sequence seq_recommend_tag_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

CREATE TABLE have_tag (
   fk_tag_UID  NUMBER   NOT NULL, -- �±׹�ȣ
   fk_tag_name VARCHAR2(100) NOT NULL,  -- �±��̸�
    fk_idx      NUMBER   NOT NULL -- ȸ��������ȣ
);

ALTER TABLE have_tag 
ADD CONSTRAINT FK_have_tag_UID FOREIGN KEY(fk_tag_UID) 
REFERENCES recommend_tag(tag_UID);

ALTER TABLE have_tag 
ADD CONSTRAINT FK_have_tag_name FOREIGN KEY(fk_tag_name) 
REFERENCES recommend_tag(tag_name);

ALTER TABLE have_tag 
ADD CONSTRAINT FK_have_tag_ide FOREIGN KEY(fk_idx) 
REFERENCES member(idx);


-- ����
CREATE TABLE review (
	review_UID         NUMBER   NOT NULL, -- �����ڵ�
	fk_idx_biz         NUMBER   NOT NULL, -- ����/�౹������ȣ
	fk_idx             NUMBER   NOT NULL, -- ȸ��������ȣ
	fk_reservation_UID NUMBER   NOT NULL, -- �����ڵ�
	startpoint         NUMBER   NOT NULL, -- ����
	fk_userid          VARCHAR2(255) NOT NULL, -- �ۼ��ھ��̵�
	fk_nickname        VARCHAR2(100) NOT NULL, -- �ۼ��ڴг���
	rv_contents        CLOB     NOT NULL, -- ���ٸ��䳻��
	rv_status          NUMBER(1)   NOT NULL, -- �������
	rv_blind           NUMBER(1)   NOT NULL, -- �������ε���� 0 ���� 1 �弳 2 ���ȸ����û 3 �Ű��� 4 ��Ÿ
	rv_writeDate       date     default sysdate NOT NULL  -- ���䳯¥
    ,CONSTRAINT PK_review PRIMARY KEY (review_UID)
    ,CONSTRAINT ck_review_status -- ������� üũ����
		check(rv_status in(0,1))
    ,CONSTRAINT ck_review_blind -- �������ε���� üũ����
		check(rv_blind in(0,1,2,3,4))
);

-- ���� ������
create sequence seq_review_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- ������(reviewComment)
CREATE TABLE review_comment (
	rc_id         NUMBER    NOT NULL, -- �����۹�ȣ
	fk_review_UID NUMBER    NOT NULL, -- �����ڵ�
	fk_idx        NUMBER    NOT NULL, -- ȸ��������ȣ
	rc_content    CLOB      NOT NULL, -- ��۳���
	rc_writedate  DATE      NOT NULL, -- ��۳�¥
	fk_rc_id      NUMBER    NOT NULL, -- ����� ������ȣ
	rc_group      NUMBER    NOT NULL, -- ��۱׷��ȣ
	rc_g_odr      NUMBER    NOT NULL, -- ��۱׷����
	rc_depth      NUMBER    NOT NULL, -- ����
	rc_blind      NUMBER(1)   NOT NULL, -- ����ε�ó������ 0 ���� 1 �弳 2 ���ȸ����û 3 �Ű��� 4 ��Ÿ
	rc_status     NUMBER(1) NULL,      -- ����
    CONSTRAINT PK_review_comment PRIMARY KEY(rc_id)
    ,CONSTRAINT ck_rc_status -- �����ۻ��� üũ����
		check(rc_status in(0,1))
    ,CONSTRAINT ck_rc_blind -- ����ε�ó������ üũ����
		check(rc_blind in(0,1,2,3,4)) 
);

-- ���� ��� ������
create sequence seq_rc_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ������
CREATE TABLE schedule (
	schedule_UID    NUMBER    NOT NULL, -- �������ڵ�
	fk_idx_biz      NUMBER    NOT NULL, -- ����/�౹������ȣ
	schedule_DATE   DATE      NOT NULL, -- ��������
	schedule_status NUMBER(1) default 0 NOT NULL  -- �������� ����: 1/ �񿹾�: 0/default: 0
    ,CONSTRAINT PK_schedule -- ������ �⺻Ű
		PRIMARY KEY (schedule_UID)
    ,CONSTRAINT ck_sch_status -- �������� üũ����
		check(schedule_status in(1,0))
    ,CONSTRAINT fk_sch_idx_biz -- ���ȸ���� -> ������
		FOREIGN KEY (fk_idx_biz)	REFERENCES biz_info(idx_biz)
);

-- ������               
create sequence seq_schedule_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;   

-- ����
CREATE TABLE reservation (
	reservation_UID    NUMBER    NOT NULL, -- �����ڵ�
	fk_idx             NUMBER    NOT NULL, -- ȸ��������ȣ
	fk_schedule_UID    NUMBER    NOT NULL, -- �������ڵ�
	fk_pet_UID         NUMBER    NOT NULL, -- �ݷ������ڵ�
	bookingdate        DATE      default sysdate NOT NULL, -- ����Ϸ��Ͻ�
	reservation_DATE   DATE      NOT NULL, -- �湮������
	reservation_status NUMBER(1) NOT NULL, -- ����������� 1 ����Ϸ�/ 2 �����Ϸ� / 3 ����Ϸ� / 4 ��� / 5 no show
	reservation_type   NUMBER    NOT NULL  -- ����Ÿ�� 1 ���� / 2 �������� / 3 ����/ 4 ȣ�ڸ�
    
    ,CONSTRAINT PK_reservation -- ���� �⺻Ű
		PRIMARY KEY (reservation_UID)
    ,CONSTRAINT ck_rev_status -- ����������� üũ����
		check(reservation_status in(1,2,3,4,5))
    ,CONSTRAINT ck_rev_type -- ����Ÿ�� üũ����
		check(reservation_type in(1, 2, 3, 4))
    ,CONSTRAINT FK_member_TO_reservation -- ȸ�� -> ����
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		)
    ,CONSTRAINT FK_schedule_TO_reservation -- ������ -> ����
		FOREIGN KEY (
			fk_schedule_UID -- �������ڵ�
		)
		REFERENCES schedule ( -- ������
			schedule_UID -- �������ڵ�
		)
);

-- ����   
create sequence seq_reservation_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

alter table reservation add fk_idx_biz NUMBER not null;
alter table reservation add constraint fk_reservation_idx_biz FOREIGN KEY (fk_idx_biz) REFERENCES biz_info(idx_biz);
                
-- �ݷ���������
CREATE TABLE pet_info (
	pet_UID         NUMBER        NOT NULL,          -- �ݷ������ڵ�
	fk_idx          NUMBER        NOT NULL,          -- ȸ��������ȣ
	pet_name        VARCHAR2(100) NOT NULL,          -- �ݷ������̸�
	pet_type        VARCHAR2(50)  NOT NULL,          -- ���� dog/cat/smallani/etc
	pet_birthday    VARCHAR2(100) NULL,              -- �ݷ���������
/*	
    [19-01-22] �μ�Ʈ ������ ���� -->   
    pet_size        VARCHAR2(2)   NULL,              -- ������ L/M/S
    pet_weight      NUMBER        NULL,              -- ������
*/  
	pet_size        VARCHAR2(1)   NOT NULL,          -- ������ L/M/S
    pet_weight      NUMBER        NOT NULL,          -- ������  
	pet_gender      NUMBER(1)     NULL,              -- ���� 1 �� 2 ��
	pet_neutral     NUMBER(1)     NULL,              -- �߼�ȭ����  0 ���� / 1 �� / 2 ��
	medical_history CLOB          NULL,              -- ���ź��±���
	allergy         CLOB          NULL,              -- �˷�������
	pet_profileimg  VARCHAR2(255) NULL,              -- �ݷ����������ʻ���
    /*	[19-01-22] �ݷ��������� �÷� �߰� */
    pet_status      VARCHAR2(1)   DEFAULT 1 NOT NULL -- �ݷ��������� 0 �������ٸ� / 1 ���� / 2 �Կ�
    ,CONSTRAINT PK_pet_info -- �ݷ��������� �⺻Ű
		PRIMARY KEY (pet_UID)
    ,CONSTRAINT ck_petinfo_gender -- �ݷ��������� üũ����
		check(pet_gender in(1,2))
    ,CONSTRAINT ck_petinfo_neutral -- �߼�ȭ���� üũ����
		check(pet_neutral in(0,1,2))  
);
/*	[19-01-22] �ݷ��������� �÷� �߰� */
alter table pet_info
add pet_status VARCHAR2(1) DEFAULT 1 NOT NULL;

create sequence seq_pet_info_UID --�ݷ���������
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ���
CREATE TABLE vaccine (
	vaccine_UID  NUMBER    NOT NULL, -- ����ڵ�
	vaccine_name VARCHAR2(100)  NOT NULL, -- ��Ÿ�
	dog          NUMBER(1) NOT NULL, -- ������
	cat          NUMBER(1) NOT NULL, -- �����
	smallani     NUMBER(1) NOT NULL  -- �ҵ���
    ,CONSTRAINT PK_vaccine -- ��� �⺻Ű
		PRIMARY KEY (vaccine_UID)
    ,CONSTRAINT ck_vaccine_dog -- ������ üũ����
		check(dog in(1,0))
    ,CONSTRAINT ck_vaccine_cat -- ����� üũ����
		check(cat in(1,0))
    ,CONSTRAINT ck_vaccine_smallani -- �ҵ��� üũ����
		check(smallani in(1,0))
);

create sequence seq_vaccine_UID  --���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��������
CREATE TABLE shots (
	shots_UID      NUMBER   NOT NULL, -- �����ڵ�
	fk_pet_UID     NUMBER   NOT NULL, -- �ݷ������ڵ�
	fk_vaccine_UID NUMBER   NOT NULL, -- ����ڵ�
	vaccine_name   VARCHAR2(100) NOT NULL  -- ��Ÿ�
    ,CONSTRAINT PK_shots -- �������� �⺻Ű
		PRIMARY KEY (shots_UID)
);
        
create sequence seq_shots_UID  --����
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �ݷ��������
CREATE TABLE pet_list (
	petlist_UID NUMBER   NOT NULL, -- ��Ϲ�ȣ
	fk_idx      NUMBER   NOT NULL, -- ȸ��������ȣ
	fk_pet_UID  NUMBER   NOT NULL, -- �ݷ������ڵ�
	fk_pet_name VARCHAR2(100) NOT NULL  -- �ݷ�������
    ,CONSTRAINT PK_pet_list -- �ݷ�������� �⺻Ű
		PRIMARY KEY (petlist_UID)
);


-- �ݷ������ɾ�
CREATE TABLE petcare (
	care_UID        NUMBER NOT NULL, -- �ɾ��ڵ�
	fk_pet_UID      NUMBER NOT NULL, -- �ݷ������ڵ�
	fk_caretype_UID NUMBER NOT NULL, -- �ɾ�Ÿ���ڵ�
	care_contents   CLOB   NOT NULL, -- ����
	care_memo       CLOB   NULL,     -- �޸�
	care_start      DATE   NOT NULL, -- �����Ͻ�
	care_end        DATE   NOT NULL, -- �����Ͻ�
	care_alarm      NUMBER(10) NULL,     -- �˸����� ���� 0/5���� 5/10���� 10/�Ϸ��� 1440 (�� ���� ȯ��)
	care_date       DATE   NOT NULL  -- �ɾ��� ����
    ,CONSTRAINT PK_petcare -- �ݷ������ɾ� �⺻Ű
		PRIMARY KEY (care_UID)
);

-- drop sequence seq_petcare_UID
create sequence seq_petcare_UID  --���ɾ�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �ɾ�Ÿ��
CREATE TABLE caretype (
	caretype_UID  NUMBER   NOT NULL, -- �ɾ�Ÿ���ڵ�
	caretype_name VARCHAR2(100) NOT NULL, -- �ɾ�Ÿ�Ը�
	caretype_info CLOB     NOT NULL  -- �ɾ�Ÿ�Ժ�����
    ,CONSTRAINT PK_caretype -- �ɾ�Ÿ�� �⺻Ű
		PRIMARY KEY (caretype_UID)
);

-- drop sequence seq_caretype_UID
create sequence seq_caretype_UID --�ɾ� Ÿ��
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ������
CREATE TABLE chart (
	chart_UID        NUMBER   NOT NULL, -- ��Ʈ�ڵ�
	fk_pet_UID       NUMBER   NOT NULL, -- �ݷ������ڵ�
	fk_idx           NUMBER   NOT NULL, -- ȸ��������ȣ
	chart_type       NUMBER(1) NOT NULL, -- ����Ÿ��  0 �౹/1 ���� / 2 �������� / 3 ���� / 4 ȣ�ڸ�
	biz_name         VARCHAR2(100) NOT NULL, -- ����/�౹��
	bookingdate      DATE     NULL,     -- ����Ϸ��Ͻ�
	reservation_DATE DATE     NULL,     -- �湮������
	doc_name         VARCHAR2(100) NULL,     -- ���ǻ��
	cautions         CLOB     NULL,     -- ���ǻ���
	chart_contents   CLOB     NULL,     -- ����
	payment_pay      NUMBER   NULL,     -- ��뿹ġ��
	payment_point    NUMBER   NULL,     -- �������Ʈ
	addpay           NUMBER   NULL,     -- ���κδ��(�߰������ݾ�)
	totalpay         NUMBER   NULL      -- ������Ѿ�
    ,CONSTRAINT PK_chart -- ������ �⺻Ű
		PRIMARY KEY (chart_UID)
    ,CONSTRAINT ck_chart_type -- ����Ÿ�� üũ����
		check(chart_type in(0,1,2,3,4))
);

create sequence chart_seq --��Ʈ
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��ġ�ݰ���
CREATE TABLE payment (
	payment_UID        NUMBER NOT NULL, -- �����ڵ�
	fk_reservation_UID NUMBER NOT NULL, -- �����ڵ�
	payment_total      NUMBER NOT NULL, -- �����Ѿ�
	payment_point      NUMBER NOT NULL, -- ��������Ʈ
	payment_pay        NUMBER NOT NULL, -- �ǰ����ݾ�
	payment_date       DATE   NOT NULL, -- ��������
	payment_status     NUMBER(1) NOT NULL  -- �������� 1 �����Ϸ� / 0 �̰��� / 2 ��� / 3 ȯ��
    ,CONSTRAINT PK_payment PRIMARY KEY (payment_UID)
    ,CONSTRAINT CK_payment_status -- �������� üũ����
		check(payment_status in(0,1,2,3))
);

-- ��ġ�ݰ��� 
create sequence seq_payment_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 

-- ��ġ��
CREATE TABLE deposit (
	deposit_UID    NUMBER   NOT NULL, -- ��ġ���ڵ�
	fk_idx         NUMBER   NOT NULL, -- ȸ��������ȣ
	depositcoin    NUMBER   NOT NULL, -- ��ġ��
	deposit_status NUMBER(1)   default 1 NOT NULL, -- ��ġ�ݻ��� 1 ��밡�� / 0 ���Ұ��� / 2 ȯ����ҽ�û / 3 ���
	deposit_type   VARCHAR2(50) NOT NULL, -- ��������
	deposit_date   DATE     default sysdate NOT NULL,  -- ��������
    FK_PAYMENT_UID number default 0 not null -- ������ȣ
    ,CONSTRAINT PK_deposit -- ��ġ�� �⺻Ű
		PRIMARY KEY (deposit_UID)
    ,CONSTRAINT CK_deposit_status -- ��ġ�ݻ��� üũ����
		check(deposit_status in(0,1,2,3))
);

-- 190124
alter table deposit
add FK_PAYMENT_UID NUMBER DEFAULT 0 NOT NULL;

-- ��ġ�� 
create sequence seq_deposit_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 

-- ȯ��
CREATE TABLE refund (
	refund_UID     NUMBER NOT NULL, -- ȯ���ڵ�
	fk_payment_UID NUMBER   NOT NULL, -- �����ڵ�
	fk_idx         NUMBER   NOT NULL, -- ȯ�ҹ���ȸ����ȣ
	fk_idx_biz     NUMBER   NOT NULL, -- ������ȣ
	refund_DATE    DATE     default sysdate NOT NULL, -- ȯ�ҽ�û����
	add_DATE       DATE     NOT NULL, -- �������
	refund_reason  VARCHAR2(255) NOT NULL, -- ȯ�һ���
	refund_money   NUMBER   NOT NULL, -- ȯ�ұݾ�
	refund_status  NUMBER(1)   default 0 NOT NULL  -- ���ο��� 1Ȯ�� 0��Ȯ��
    ,CONSTRAINT PK_refund -- ȯ�� �⺻Ű
		PRIMARY KEY (refund_UID)
    ,CONSTRAINT CK_refund_status -- ���ο��� üũ����
		check(refund_status in(0,1))
);

-- ȯ�� 
create sequence seq_refund_refund_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 



-- �˸�
CREATE TABLE notification (
	not_UID       NUMBER   NOT NULL, -- �˸��ڵ�
	fk_idx        NUMBER   NOT NULL, -- ȸ��������ȣ
	not_type     NUMBER(1) NOT NULL, -- �˸�����  0 ��ü���� / 1 petcare / 2 reservation / 3 payment / 4 board / 5 ȭ��ä��
	not_message   CLOB     NOT NULL, -- �˸�����
	not_date      DATE     NOT NULL, -- �˸��߼��Ͻ�
	not_readcheck NUMBER(1)   default 0 NOT NULL  -- Ȯ�ο��� Ȯ�� 1 / ��Ȯ�� 0
    ,CONSTRAINT PK_notification -- �˸� �⺻Ű
		PRIMARY KEY (not_UID)
    ,CONSTRAINT CK_not_type -- �˸����� üũ����
		check(not_type in(0,1,2,3,4))
    ,CONSTRAINT CK_not_readcheck -- Ȯ�ο��� üũ����
		check(not_readcheck in(0,1))
);

alter table notification drop constraint CK_not_type;

alter table notification
add constraint CK_not_type check (not_type in(0,1,2,3,4,5));

alter table notification
add not_remindstatus NUMBER(1) default 0 NOT NULL; -- ��˸� ����

alter table notification
add CONSTRAINT CK_not_remindstatus  check(not_remindstatus in (0,1)); -- ��˶� ���� ���������߰�

alter table notification
add not_time DATE default sysdate NOT NULL; -- ����˸� �����ð�

alter table notification
add not_URL VARCHAR2(200) default 'http://localhost:9090/petopia/alarm.pet' NOT NULL; -- �̵�url


create sequence seq_notification_UID --�˶�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��ġ�����
CREATE TABLE withdraw (
	withdraw_UID    NUMBER NOT NULL, -- ����ڵ�
	fk_deposit_UID  NUMBER NOT NULL, -- ��ġ���ڵ�
	withdraw_money  NUMBER NOT NULL, -- ��ݿ�û�ݾ�
	withdraw_status NUMBER(1) default 0 NOT NULL  -- ��ݻ��� 1 �Ϸ� / 0 ���
    ,CONSTRAINT PK_withdraw -- ��ġ����� �⺻Ű
		PRIMARY KEY (withdraw_UID)
    ,CONSTRAINT CK_withdraw_status -- ��ݻ��� üũ����
		check(withdraw_status in(0,1))
);

-- ��ġ����� 
create sequence seq_withdraw_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 


-- ��ġ�� ��볻��
CREATE TABLE dep_use (
	dep_use_UID        NUMBER NOT NULL, -- ��볻���ڵ�
	fk_deposit_UID     NUMBER NOT NULL,     -- ��ġ���ڵ�
	fk_payment_UID     NUMBER NOT NULL,     -- �����ڵ�
	fk_reservation_UID NUMBER NOT NULL,     -- �����ڵ�
	depu_money         NUMBER NOT NULL,     -- ���ݾ�
	deposit_usedate    DATE   default sysdate NOT NULL  -- �������
    ,CONSTRAINT PK_dep_use -- ��ġ�� ��볻�� �⺻Ű
		PRIMARY KEY (dep_use_UID)
);

-- ��볻�� 
create sequence seq_dep_use_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 

-- ó����
CREATE TABLE prescription (
	rx_UID      number       NOT NULL, -- ó���ڵ�
	chart_UID   NUMBER       NOT NULL, -- ��Ʈ�ڵ�
	rx_name     varchar2(100) NOT NULL, -- ó���
	dose_number varchar2(100) NULL,     -- ����Ƚ��
	dosage      varchar2(100) NULL,     -- ����뷮
	rx_notice   CLOB         NULL,     -- ó��ȳ�
	rx_cautions varchar2(100) NULL,     -- ���ǻ���
	rx_regName  varchar2(100) NOT NULL  -- ����ѻ��
    ,CONSTRAINT PK_prescription -- ó���� �⺻Ű
		PRIMARY KEY (rx_UID)
);

create sequence seq_prescription_UID --ó��
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ȭ�� ���(video advice)
CREATE TABLE video_advice (
	va_UID      NUMBER       NOT NULL, -- ȭ���� ��ȣ
	fk_idx      NUMBER       NOT NULL, -- ȸ��������ȣ
	fk_idx_biz  NUMBER       NOT NULL, -- ����/�౹������ȣ
	chatcode    VARCHAR2(20) NOT NULL, -- ä�ù� �ڵ�
	fk_userid   VARCHAR2(255)     NOT NULL, -- ȸ�����̵�
	fk_name_biz VARCHAR2(100)     NOT NULL, -- ������
	fk_docname  VARCHAR2(100)     NOT NULL, -- ���ǻ��
	usermessage CLOB         NULL, -- ȸ���� ���� �޼���
	docmessage  CLOB         NULL, -- ���ǻ簡 ���� �޼���
	umtime      DATE NULL, -- ȸ���� �޼������� �ð�
	dmtime      DATE NULL,  -- ���ǻ簡 �޼������� �ð�
    startTime date default sysdate NOT NULL,  -- ȭ��ä�� ���۽ð�
    endTime  date  NULL  -- ȭ��ä�� ����ð�

    ,CONSTRAINT PK_video_advice -- ȭ�� ���(video advice) �⺻Ű
		PRIMARY KEY (va_UID)
);

create sequence seq_video_advice_UID  --ȭ����
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 1:1���
CREATE TABLE consult (
	consult_UID NUMBER   NOT NULL, -- ����ڵ�
	fk_idx      NUMBER   NOT NULL, -- ȸ��������ȣ
	cs_pet_type NUMBER(1) NOT NULL, -- �����з� 1 ������ / 2 ����� / 3 �ҵ��� / 4 ��Ÿ
	cs_title    VARCHAR2(100) NOT NULL, -- �������
	cs_contents CLOB     NOT NULL, -- ��㳻��
	cs_hit      NUMBER   NOT NULL, -- ��ȸ��
	cs_writeday DATE     NOT NULL, -- �ۼ�����
	cs_secret   NUMBER(1)   NOT NULL  -- �������� 0 ����� / 1 ����
    ,CONSTRAINT PK_consult -- 1:1��� �⺻Ű
		PRIMARY KEY (consult_UID)
    ,CONSTRAINT ck_consult_type -- �����з� üũ����
		check(cs_pet_type in(1,2,3,4))
    ,CONSTRAINT ck_cs_secret -- �������� üũ����
		check(cs_secret in(0,1))
);
  
create sequence seq_consult_UID --1:1 ���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

alter table consult
modify cs_writeday default sysdate;
alter table consult
modify cs_hit default 0;
alter table consult
add commentCount VARCHAR2(100) default 0 NOT NULL;

-- 1:1��� ���
CREATE TABLE consult_comment (
	cmt_id         NUMBER   NOT NULL, -- ��۰�����ȣ
	fk_consult_UID NUMBER   NOT NULL, -- ����ڵ�
	fk_idx         NUMBER   NOT NULL, -- ���ȸ��������ȣ
	cscmt_nickname VARCHAR2(100) NOT NULL, -- ����ۼ���
	cscmt_contents CLOB     NOT NULL, -- ��۳���
	cscmt_writeday DATE     NOT NULL, -- ����ۼ��Ͻ�
	fk_cmt_id      NUMBER   NOT NULL, -- ����� ������ȣ
	cscmt_group    NUMBER default 0  NOT NULL, -- ��۱׷��ȣ
	cscmt_g_odr    NUMBER   default 0 NOT NULL, -- ��۱׷����
	cscmt_depth    NUMBER   default 0 NOT NULL, -- ����
	cscmt_del      NUMBER(1)   default 1 NOT NULL  -- �������� 0���� / 1 ��밡��
    ,CONSTRAINT PK_consult_comment PRIMARY KEY (cmt_id)
    ,CONSTRAINT ck_cscmt_del -- �������� üũ����
		check(cscmt_del in(1,0))
);

create sequence seq_consult_comment  --1:1 ��� ���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

alter table consult_comment
modify cscmt_writeday default sysdate;

-- ���ɾ� �̹���
CREATE TABLE petcare_img (
	pc_img_UID  NUMBER   NOT NULL, -- �̹�����ȣ
	fk_care_UID NUMBER   NOT NULL, -- �ɾ��ڵ�
	pc_img_name VARCHAR2(255) NOT NULL  -- �̹�����
    ,CONSTRAINT PK_petcare_img -- ���ɾ� �̹��� �⺻Ű
		PRIMARY KEY (pc_img_UID)
);

create sequence petcare_img_seq  --���ɾ� �̹���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �Խ��Ǳ׷�
CREATE TABLE board_group (
	brd_id    NUMBER   NOT NULL, -- �Խ��Ǳ׷��ڵ�
	brd_name  VARCHAR2(20) NOT NULL, -- �Խ��Ǹ�
	brd_grant NUMBER(1)   NOT NULL  -- �۾������ (1, 2, 3)
    ,CONSTRAINT PK_board_group -- �Խ��Ǳ׷� �⺻Ű
		PRIMARY KEY (brd_id)
    ,CONSTRAINT ck_brd_grant -- �۾������ üũ����
		check(brd_grant in(1,2,3))
);
        
create sequence board_group_seq --�Խ��� �׷�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �Խñ�
CREATE TABLE board_post (
	post_id          NUMBER   NOT NULL, -- �Խñ۰�����ȣ
	fk_brd_id        NUMBER   NOT NULL, -- �Խ��Ǳ׷��ڵ�
	post_title       VARCHAR2(100) NOT NULL, -- �Խñ�����
	post_contents    CLOB     NOT NULL, -- �Խñ۳���
	fk_idx           NUMBER   NOT NULL, -- �ۼ��ڰ�����ȣ
	fk_nickname      VARCHAR2(100) NOT NULL, -- �ۼ���
	post_writeday    DATE     NOT NULL, -- �ۼ���
	post_hit         NUMBER   NOT NULL, -- ��ȸ��
	post_del         NUMBER(1)   NOT NULL, -- ��������
	post_repcnt      NUMBER   NOT NULL, -- ��ۼ�
	post_imgfilename VARCHAR2(255) NULL      -- ��ǥ�̹���
    ,CONSTRAINT PK_board_post -- �Խñ� �⺻Ű
		PRIMARY KEY (post_id)
    ,CONSTRAINT ck_post_del -- �������� üũ����
		check(post_del in(0,1))
);
        
create sequence seq_board_post --�Խñ�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ���
CREATE TABLE board_comment (
	cmt_id       NUMBER   NOT NULL, -- ��۰�����ȣ
	fk_brd_id    NUMBER   NOT NULL, -- �Խ��Ǳ׷��ڵ�
	fk_post_id   NUMBER   NOT NULL, -- �Խñ۰�����ȣ
	fk_idx       NUMBER   NOT NULL, -- ����ۼ��ڰ�����ȣ
	fk_nickname  VARCHAR2(100) NOT NULL, -- ����ۼ���
	cmt_contents CLOB     NOT NULL, -- ��۳���
	cmt_writeday DATE     NOT NULL, -- ����ۼ��Ͻ�
	cmt_group    NUMBER   NOT NULL, -- ��۱׷��ȣ
	cmt_g_odr    NUMBER   NOT NULL, -- ��۱׷����
	cmt_depth    NUMBER   NOT NULL, -- ����
	cmt_del      NUMBER(1)   NOT NULL  -- ��������
    ,CONSTRAINT PK_comment PRIMARY KEY (cmt_id)
    ,CONSTRAINT ck_cmt_del -- �������� üũ����
		check(cmt_del in(0,1))
);
        
create sequence board_comment_seq --���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


---- �̺�Ʈ
--CREATE TABLE event (
--	ev_id          NUMBER   NOT NULL, -- �̺�Ʈ�ڵ�
--	ev_title       VARCHAR2(255) NOT NULL, -- �̺�Ʈ����
--	ev_contents    CLOB     NOT NULL, -- �̺�Ʈ����
--	ev_imgfilename VARCHAR2(255) NOT NULL, -- �̺�Ʈ���
--	ev_start       DATE     NOT NULL, -- �̺�Ʈ����
--	ev_end         DATE     NOT NULL  -- �̺�Ʈ����
--    ,CONSTRAINT PK_event -- �̺�Ʈ �⺻Ű
--		PRIMARY KEY (ev_id)
--);
--
---- ���⵿���Ŀ�
--CREATE TABLE funding (
--	fd_id          NUMBER   NOT NULL, -- �Ŀ��ڵ�
--	fd_title       VARCHAR2 NOT NULL, -- �Ŀ�����
--	fd_orgname     VARCHAR2 NOT NULL, -- ��ü�׽ü��̸�
--	region         VARCHAR2 NOT NULL, -- ����
--	fd_name        VARCHAR2 NOT NULL, -- ��ǥ��
--	fd_phone       VARCHAR2 NOT NULL, -- ����ó
--	fd_goal        NUMBER   NOT NULL, -- �Ŀ���ݾ�
--	fd_start       DATE     NOT NULL, -- ������
--	fd_end         DATE     NOT NULL, -- ������
--	fd_imgfilename VARCHAR2 NOT NULL, -- ��ǥ�̹���
--	fd_contents    CLOB     NOT NULL  -- �Ŀ�����
--);
--
---- ���⵿���Ŀ�
--ALTER TABLE funding
--	ADD
--		CONSTRAINT PK_funding -- ���⵿���Ŀ� �⺻Ű
--		PRIMARY KEY (
--			fd_id -- �Ŀ��ڵ�
--		);
--
---- ���⵿���Ŀ��̹���
--CREATE TABLE funding_img (
--	fdimg_id   NUMBER   NOT NULL, -- �Ŀ��̹����ڵ�
--	fk_fd_id   NUMBER   NOT NULL, -- �Ŀ��ڵ�
--	fdimg_name VARCHAR2 NOT NULL  -- �̹������ϸ�
--);
--
---- ���⵿���Ŀ��̹���
--ALTER TABLE funding_img
--	ADD
--		CONSTRAINT PK_funding_img -- ���⵿���Ŀ��̹��� �⺻Ű
--		PRIMARY KEY (
--			fdimg_id -- �Ŀ��̹����ڵ�
--		);
--
---- �ݵ�����
--CREATE TABLE funding_payment (
--	payment_UID    NUMBER NOT NULL, -- �����ڵ�
--	fk_fd_id       NUMBER NOT NULL, -- �Ŀ��ڵ�
--	payment_total  NUMBER NOT NULL, -- �����Ѿ�
--	payment_point  NUMBER NOT NULL, -- ��������Ʈ
--	payment_pay    NUMBER NOT NULL, -- �ǰ����ݾ�
--	payment_date   DATE   NOT NULL, -- ��������
--	payment_status NUMBER NOT NULL  -- ��������
--);
--
---- �ݵ�����
--ALTER TABLE funding_payment
--	ADD
--		CONSTRAINT PK_funding_payment -- �ݵ����� �⺻Ű
--		PRIMARY KEY (
--			payment_UID -- �����ڵ�
--		);
--
---- �ݵ�ȯ��
--CREATE TABLE funding_refund (
--	refund_UID     VARCHAR2 NOT NULL, -- ȯ���ڵ�
--	fk_payment_UID NUMBER   NOT NULL, -- �����ڵ�
--	fk_idx         NUMBER   NOT NULL, -- ȯ�ҹ���ȸ����ȣ
--	refund_DATE    DATE     NOT NULL, -- ȯ�ҽ�û����
--	add_DATE       DATE     NOT NULL, -- �������
--	refund_reason  VARCHAR2 NOT NULL, -- ȯ�һ���
--	refund_money   NUMBER   NOT NULL, -- ȯ�ұݾ�
--	refund_status  NUMBER   NOT NULL  -- ���ο���
--);
--
---- �ݵ�ȯ��
--ALTER TABLE funding_refund
--	ADD
--		CONSTRAINT PK_funding_refund -- �ݵ�ȯ�� �⺻Ű
--		PRIMARY KEY (
--			refund_UID -- ȯ���ڵ�
--		);
------------------------------------------------------------------------------


-- #�������� �߰�


-- �Ƿ���
ALTER TABLE doctors
	ADD
		CONSTRAINT FK_biz_info_TO_doctors -- ���ȸ���� -> �Ƿ���
		FOREIGN KEY (
			fk_idx_biz -- ����/�౹������ȣ
		)
		REFERENCES biz_info ( -- ���ȸ����
			idx_biz -- ����/�౹������ȣ
		);


-- ����
ALTER TABLE review
	ADD
		CONSTRAINT FK_biz_info_TO_review -- ���ȸ���� -> ����
		FOREIGN KEY (
			fk_idx_biz -- ����/�౹������ȣ
		)
		REFERENCES biz_info ( -- ���ȸ����
			idx_biz -- ����/�౹������ȣ
		);

-- ����
ALTER TABLE review
	ADD
		CONSTRAINT FK_member_TO_review -- ȸ�� -> ����
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ����
ALTER TABLE review
	ADD
		CONSTRAINT FK_reservation_TO_review -- ���� -> ����
		FOREIGN KEY (
			fk_reservation_UID -- �����ڵ�
		)
		REFERENCES reservation ( -- ����
			reservation_UID -- �����ڵ�
		);

-- ����
ALTER TABLE reservation
	ADD
		CONSTRAINT FK_pet_info_TO_reservation -- �ݷ��������� -> ����
		FOREIGN KEY (
			fk_pet_UID -- �ݷ������ڵ�
		)
		REFERENCES pet_info ( -- �ݷ���������
			pet_UID -- �ݷ������ڵ�
		);


-- �ݷ���������
ALTER TABLE pet_info
	ADD
		CONSTRAINT FK_member_TO_pet_info -- ȸ�� -> �ݷ���������
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ��������
ALTER TABLE shots
	ADD
		CONSTRAINT FK_vaccine_TO_shots -- ��� -> ��������
		FOREIGN KEY (
			fk_vaccine_UID -- ����ڵ�
		)
		REFERENCES vaccine ( -- ���
			vaccine_UID -- ����ڵ�
		);

-- ��������
ALTER TABLE shots
	ADD
		CONSTRAINT FK_pet_info_TO_shots -- �ݷ��������� -> ��������
		FOREIGN KEY (
			fk_pet_UID -- �ݷ������ڵ�
		)
		REFERENCES pet_info ( -- �ݷ���������
			pet_UID -- �ݷ������ڵ�
		);

-- �ݷ��������
ALTER TABLE pet_list
	ADD
		CONSTRAINT FK_member_TO_pet_list -- ȸ�� -> �ݷ��������
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- �ݷ��������
ALTER TABLE pet_list
	ADD
		CONSTRAINT FK_pet_info_TO_pet_list -- �ݷ��������� -> �ݷ��������
		FOREIGN KEY (
			fk_pet_UID -- �ݷ������ڵ�
		)
		REFERENCES pet_info ( -- �ݷ���������
			pet_UID -- �ݷ������ڵ�
		);

-- �ݷ������ɾ�
ALTER TABLE petcare
	ADD
		CONSTRAINT FK_pet_info_TO_petcare -- �ݷ��������� -> �ݷ������ɾ�
		FOREIGN KEY (
			fk_pet_UID -- �ݷ������ڵ�
		)
		REFERENCES pet_info ( -- �ݷ���������
			pet_UID -- �ݷ������ڵ�
		);

-- �ݷ������ɾ�
ALTER TABLE petcare
	ADD
		CONSTRAINT FK_caretype_TO_petcare -- �ɾ�Ÿ�� -> �ݷ������ɾ�
		FOREIGN KEY (
			fk_caretype_UID -- �ɾ�Ÿ���ڵ�
		)
		REFERENCES caretype ( -- �ɾ�Ÿ��
			caretype_UID -- �ɾ�Ÿ���ڵ�
		);

-- ������
ALTER TABLE chart
	ADD
		CONSTRAINT FK_pet_info_TO_chart -- �ݷ��������� -> ������
		FOREIGN KEY (
			fk_pet_UID -- �ݷ������ڵ�
		)
		REFERENCES pet_info ( -- �ݷ���������
			pet_UID -- �ݷ������ڵ�
		);

-- ������
ALTER TABLE chart
	ADD
		CONSTRAINT FK_member_TO_chart -- ȸ�� -> ������
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ��ġ�ݰ���
ALTER TABLE payment
	ADD
		CONSTRAINT FK_reservation_TO_payment -- ���� -> ��ġ�ݰ���
		FOREIGN KEY (
			fk_reservation_UID -- �����ڵ�
		)
		REFERENCES reservation ( -- ����
			reservation_UID -- �����ڵ�
		);

-- ��ġ��
ALTER TABLE deposit
	ADD
		CONSTRAINT FK_member_TO_deposit -- ȸ�� -> ��ġ��
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ȯ��
ALTER TABLE refund
	ADD
		CONSTRAINT FK_payment_TO_refund -- ��ġ�ݰ��� -> ȯ��
		FOREIGN KEY (
			fk_payment_UID -- �����ڵ�
		)
		REFERENCES payment ( -- ��ġ�ݰ���
			payment_UID -- �����ڵ�
		);


-- 1:1���
ALTER TABLE consult
	ADD
		CONSTRAINT FK_member_TO_consult -- ȸ�� -> 1:1���
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- �˸�
ALTER TABLE notification
	ADD
		CONSTRAINT FK_member_TO_notification -- ȸ�� -> �˸�
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ��ġ�����
ALTER TABLE withdraw
	ADD
		CONSTRAINT FK_deposit_TO_withdraw -- ��ġ�� -> ��ġ�����
		FOREIGN KEY (
			fk_deposit_UID -- ��ġ���ڵ�
		)
		REFERENCES deposit ( -- ��ġ��
			deposit_UID -- ��ġ���ڵ�
		);

-- ��ġ�� ��볻��
ALTER TABLE dep_use
	ADD
		CONSTRAINT FK_deposit_TO_dep_use -- ��ġ�� -> ��ġ�� ��볻��
		FOREIGN KEY (
			fk_deposit_UID -- ��ġ���ڵ�
		)
		REFERENCES deposit ( -- ��ġ��
			deposit_UID -- ��ġ���ڵ�
		);

-- ��ġ�� ��볻��
ALTER TABLE dep_use
	ADD
		CONSTRAINT FK_payment_TO_dep_use -- ��ġ�ݰ��� -> ��ġ�� ��볻��
		FOREIGN KEY (
			fk_payment_UID -- �����ڵ�
		)
		REFERENCES payment ( -- ��ġ�ݰ���
			payment_UID -- �����ڵ�
		);

-- ��ġ�� ��볻��
ALTER TABLE dep_use
	ADD
		CONSTRAINT FK_reservation_TO_dep_use -- ���� -> ��ġ�� ��볻��
		FOREIGN KEY (
			fk_reservation_UID -- �����ڵ�
		)
		REFERENCES reservation ( -- ����
			reservation_UID -- �����ڵ�
		);

-- ó����
ALTER TABLE prescription
	ADD
		CONSTRAINT FK_chart_TO_prescription -- ������ -> ó����
		FOREIGN KEY (
			chart_UID -- ��Ʈ�ڵ�
		)
		REFERENCES chart ( -- ������
			chart_UID -- ��Ʈ�ڵ�
		);

-- ȭ�� ���(video advice)
ALTER TABLE video_advice
	ADD
		CONSTRAINT FK_member_TO_video_advice -- ȸ�� -> ȭ�� ���(video advice)
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ȭ�� ���(video advice)
ALTER TABLE video_advice
	ADD
		CONSTRAINT FK_biz_info_TO_video_advice -- ���ȸ���� -> ȭ�� ���(video advice)
		FOREIGN KEY (
			fk_idx_biz -- ����/�౹������ȣ
		)
		REFERENCES biz_info ( -- ���ȸ����
			idx_biz -- ����/�౹������ȣ
		);


-- ������(reviewComment)
ALTER TABLE review_comment
	ADD
		CONSTRAINT FK_review_TO_review_comment -- ���� -> ������(reviewComment)
		FOREIGN KEY (
			fk_review_UID -- �����ڵ�
		)
		REFERENCES review ( -- ����
			review_UID -- �����ڵ�
		);

-- ������(reviewComment)
ALTER TABLE review_comment
	ADD
		CONSTRAINT FK_member_TO_review_comment -- ȸ�� -> ������(reviewComment)
		FOREIGN KEY (
			fk_idx -- ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- 1:1��� ���
ALTER TABLE consult_comment
	ADD
		CONSTRAINT FK_consult_TO_consult_comment -- 1:1��� -> 1:1��� ���
		FOREIGN KEY (
			fk_consult_UID -- ����ڵ�
		)
		REFERENCES consult ( -- 1:1���
			consult_UID -- ����ڵ�
		);

-- 1:1��� ���
ALTER TABLE consult_comment
	ADD
		CONSTRAINT FK_member_TO_consult_comment -- ȸ�� -> 1:1��� ���
		FOREIGN KEY (
			fk_idx -- ���ȸ��������ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ���ɾ� �̹���
ALTER TABLE petcare_img
	ADD
		CONSTRAINT FK_petcare_TO_petcare_img -- �ݷ������ɾ� -> ���ɾ� �̹���
		FOREIGN KEY (
			fk_care_UID -- �ɾ��ڵ�
		)
		REFERENCES petcare ( -- �ݷ������ɾ�
			care_UID -- �ɾ��ڵ�
		);
        
        
-- #������� ���� �������� �߰�
-- �Խñ�
ALTER TABLE board_post
	ADD
		CONSTRAINT FK_board_group_TO_board_post -- �Խ��Ǳ׷� -> �Խñ�
		FOREIGN KEY (
			fk_brd_id -- �Խ��Ǳ׷��ڵ�
		)
		REFERENCES board_group ( -- �Խ��Ǳ׷�
			brd_id -- �Խ��Ǳ׷��ڵ�
		)
		
		;

-- �Խñ�
ALTER TABLE board_post
	ADD
		CONSTRAINT FK_member_TO_board_post -- ȸ�� -> �Խñ�
		FOREIGN KEY (
			fk_idx -- �ۼ��ڰ�����ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		)
		
		;

-- ���
ALTER TABLE board_comment
	ADD
		CONSTRAINT FK_board_group_TO_comment -- �Խ��Ǳ׷� -> ���
		FOREIGN KEY (
			fk_brd_id -- �Խ��Ǳ׷��ڵ�
		)
		REFERENCES board_group ( -- �Խ��Ǳ׷�
			brd_id -- �Խ��Ǳ׷��ڵ�
		);

-- ���
ALTER TABLE board_comment
	ADD
		CONSTRAINT FK_board_post_TO_comment -- �Խñ� -> ���
		FOREIGN KEY (
			fk_post_id -- �Խñ۰�����ȣ
		)
		REFERENCES board_post ( -- �Խñ�
			post_id -- �Խñ۰�����ȣ
		)
		
		;

-- ���
ALTER TABLE board_comment
	ADD
		CONSTRAINT FK_member_TO_comment -- ȸ�� -> ���
		FOREIGN KEY (
			fk_idx -- ����ۼ��ڰ�����ȣ
		)
		REFERENCES member ( -- ȸ��
			idx -- ȸ��������ȣ
		);

-- ���⵿���Ŀ��̹���
ALTER TABLE funding_img
	ADD
		CONSTRAINT FK_funding_TO_funding_img -- ���⵿���Ŀ� -> ���⵿���Ŀ��̹���
		FOREIGN KEY (
			fk_fd_id -- �Ŀ��ڵ�
		)
		REFERENCES funding ( -- ���⵿���Ŀ�
			fd_id -- �Ŀ��ڵ�
		);

-- �ݵ�����
ALTER TABLE funding_payment
	ADD
		CONSTRAINT FK_funding_TO_funding_payment -- ���⵿���Ŀ� -> �ݵ�����
		FOREIGN KEY (
			fk_fd_id -- �Ŀ��ڵ�
		)
		REFERENCES funding ( -- ���⵿���Ŀ�
			fd_id -- �Ŀ��ڵ�
		);

-- �ݵ�ȯ��
ALTER TABLE funding_refund
	ADD
		CONSTRAINT FK_funding_payment_TO_funding_refund -- �ݵ����� -> �ݵ�ȯ��
		FOREIGN KEY (
			fk_payment_UID -- �����ڵ�
		)
		REFERENCES funding_payment ( -- �ݵ�����
			payment_UID -- �����ڵ�
		);
        

-- ������ ȸ�� ����Ʈ ���ν���(�˻�X ����X) ++ [190125] ���ν��� where�� �߰�
create or replace procedure pcd_selectMemberList
(   p_startno       IN      member.idx%TYPE
  , p_endno         IN      member.idx%TYPE
  , cur_member_list OUT     SYS_REFCURSOR
)
is
begin
    OPEN cur_member_list FOR
    select rno, idx, userid, name, nickname, phone, noshow, member_status, lastlogindategap
    from
    (
        select rownum as rno, idx, userid, name, nickname, phone, noshow, member_status, lastlogindategap
        from 
        (
            select a.idx, userid, name, nickname, phone, noshow, member_status
                , trunc(months_between(sysdate, lastlogindate)) AS lastlogindategap
            from member a JOIN login_log b
            ON a.idx = b.idx
            where a.membertype = 1
            order by idx asc
        ) V
    ) T
    where rno between p_startno and p_endno;
end pcd_selectMemberList;

-- [190126] ����ȸ���� ���� ���ེ���� ���� ���ν��� (�п�PC���� �����Ǿ�����)
create or replace procedure pcd_firstAddSchedule(p_idx_biz IN number)
is
    v_weekday varchar2(1); 
begin
        select substr(weekday, -2, 1) as weekday into v_weekday from biz_info where idx_biz = p_idx_biz;
        
        if(v_weekday='5')
        then
            insert into schedule(schedule_UID, fk_idx_biz, schedule_DATE)
            select seq_schedule_UID.nextval, idx_biz, scheduledate
            from
            (
            select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
            from
            (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
             from   (select wdstart s,
                           lunchstart e,
                           idx_biz
                    from   biz_info
                    where idx_biz = p_idx_biz)
            connect by s + (((level*0.5)-0.5)/24) < e) T
            left join 
            (
            SELECT A.DT
              FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                               TO_CHAR (SDT + LEVEL - 1, 'D') D
                          FROM (SELECT sysdate SDT,
                                       sysdate+14  EDT
                                  FROM dual)
                    CONNECT BY LEVEL <= EDT - SDT + 1) A
            WHERE A.D NOT IN ('1', '7') 
            ) V
            on 1=1
            UNION
            select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
            from
            (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
             from   (select lunchend s,
                           wdend e,
                           idx_biz
                    from   biz_info
                    where idx_biz = p_idx_biz)
            connect by s + (((level*0.5)-0.5)/24) < e) T
            left join 
            (
            SELECT A.DT
              FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                               TO_CHAR (SDT + LEVEL - 1, 'D') D
                          FROM (SELECT sysdate SDT,
                                       sysdate+14  EDT
                                  FROM dual)
                    CONNECT BY LEVEL <= EDT - SDT + 1) A
            WHERE A.D NOT IN ('1', '7') 
            ) V
            on 1=1
            order by 1);
            
        elsif(v_weekday=4)
        then
            insert into schedule(schedule_UID, fk_idx_biz, schedule_DATE)
            select seq_schedule_UID.nextval, idx_biz, scheduledate
            from
            (
            select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
            from
            (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
             from   (select wdstart s,
                           lunchstart e,
                           idx_biz
                    from   biz_info
                    where idx_biz = p_idx_biz)
            connect by s + (((level*0.5)-0.5)/24) < e) T
            left join 
            (
            SELECT A.DT
              FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                               TO_CHAR (SDT + LEVEL - 1, 'D') D
                          FROM (SELECT sysdate SDT,
                                       sysdate+14  EDT
                                  FROM dual)
                    CONNECT BY LEVEL <= EDT - SDT + 1) A
            WHERE A.D NOT IN ('1', '2', '7') 
            ) V
            on 1=1
            UNION
            select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
            from
            (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
             from   (select lunchend s,
                           wdend e,
                           idx_biz
                    from   biz_info
                    where idx_biz = p_idx_biz)
            connect by s + (((level*0.5)-0.5)/24) < e) T
            left join 
            (
            SELECT A.DT
              FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                               TO_CHAR (SDT + LEVEL - 1, 'D') D
                          FROM (SELECT sysdate SDT,
                                       sysdate+14  EDT
                                  FROM dual)
                    CONNECT BY LEVEL <= EDT - SDT + 1) A
            WHERE A.D NOT IN ('1', '2', '7') 
            ) V
            on 1=1
            order by 1);
        elsif(v_weekday='3')
        then
            insert into schedule(schedule_UID, fk_idx_biz, schedule_DATE)
            select seq_schedule_UID.nextval, idx_biz, scheduledate
            from
            (
            select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
            from
            (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
             from   (select wdstart s,
                           lunchstart e,
                           idx_biz
                    from   biz_info
                    where idx_biz = p_idx_biz)
            connect by s + (((level*0.5)-0.5)/24) < e) T
            left join 
            (
            SELECT A.DT
              FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                               TO_CHAR (SDT + LEVEL - 1, 'D') D
                          FROM (SELECT sysdate SDT,
                                       sysdate+14  EDT
                                  FROM dual)
                    CONNECT BY LEVEL <= EDT - SDT + 1) A
            WHERE A.D NOT IN ('1', '3', '5', '7') 
            ) V
            on 1=1
            UNION
            select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
            from
            (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
             from   (select lunchend s,
                           wdend e,
                           idx_biz
                    from   biz_info
                    where idx_biz = p_idx_biz)
            connect by s + (((level*0.5)-0.5)/24) < e) T
            left join 
            (
            SELECT A.DT
              FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                               TO_CHAR (SDT + LEVEL - 1, 'D') D
                          FROM (SELECT sysdate SDT,
                                       sysdate+14  EDT
                                  FROM dual)
                    CONNECT BY LEVEL <= EDT - SDT + 1) A
            WHERE A.D NOT IN ('1', '3', '5', '7') 
            ) V
            on 1=1
            order by 1);
        end if;
        insert into schedule(schedule_UID, fk_idx_biz, schedule_DATE)
        select seq_schedule_UID.nextval, idx_biz, scheduledate
        from
        (
        select idx_biz, to_date(V.DT || ''|| T.time_str, 'yyyy-mm-dd hh24:mi') as scheduledate
        from
        (select to_char(s + (((level*0.5)-0.5)/24), 'hh24:mi') as time_str, idx_biz
         from   (select satstart s,
                       satend e,
                       idx_biz
                from   biz_info
                where idx_biz = p_idx_biz)
        connect by s + (((level*0.5)-0.5)/24) < e) T
        left join 
        (
        SELECT A.DT, A.D
          FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                           TO_CHAR (SDT + LEVEL - 1, 'D') D
                      FROM (SELECT sysdate SDT,
                                   sysdate+14  EDT
                              FROM dual)
                CONNECT BY LEVEL <= EDT - SDT + 1) A
        WHERE A.D = '7'
        ) V
        on 1=1
        order by 1
        );
end;