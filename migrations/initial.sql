--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';



--
-- Name: enum_Customers_type; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Customers_type" AS ENUM (
    'ct-attorney',
    'ct-law-firm',
    'ct-reporter',
    'ct-reporting-firm'
);


ALTER TYPE "enum_Customers_type" OWNER TO dmitru;

--
-- Name: enum_ExpenseEntries_type; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_ExpenseEntries_type" AS ENUM (
    'et-government',
    'et-private'
);


ALTER TYPE "enum_ExpenseEntries_type" OWNER TO dmitru;

--
-- Name: enum_Invoices_accountingType; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Invoices_accountingType" AS ENUM (
    'iat-na',
    'iat-appeal',
    'iat-judicial-officer-no-charge',
    'iat-arraign-plea-sentance-no-charge'
);


ALTER TYPE "enum_Invoices_accountingType" OWNER TO dmitru;

--
-- Name: enum_Invoices_caseType; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Invoices_caseType" AS ENUM (
    'ict-civil',
    'ict-criminal'
);


ALTER TYPE "enum_Invoices_caseType" OWNER TO dmitru;

--
-- Name: enum_Invoices_realtimeProvided; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Invoices_realtimeProvided" AS ENUM (
    'irp-none',
    'irp-us-attorney',
    'irp-pub-defender',
    'irp-non-governmental-party'
);


ALTER TYPE "enum_Invoices_realtimeProvided" OWNER TO dmitru;

--
-- Name: enum_Invoices_recipientType; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Invoices_recipientType" AS ENUM (
    'irt-private',
    'irt-official'
);


ALTER TYPE "enum_Invoices_recipientType" OWNER TO dmitru;

--
-- Name: enum_Invoices_type; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Invoices_type" AS ENUM (
    'it-federal',
    'it-state-and-freelance',
    'it-proofreading-and-scoping'
);


ALTER TYPE "enum_Invoices_type" OWNER TO dmitru;

--
-- Name: enum_Notifications_type; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Notifications_type" AS ENUM (
    'nt-custom',
    'nt-incoming-invoice',
    'nt-invoice-payment-received',
    'nt-invoice-paid'
);


ALTER TYPE "enum_Notifications_type" OWNER TO dmitru;

--
-- Name: enum_SentEmails_type; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_SentEmails_type" AS ENUM (
    'et-invoice',
    'et-invoice-payment-received',
    'et-transcript-request'
);


ALTER TYPE "enum_SentEmails_type" OWNER TO dmitru;

--
-- Name: enum_TimeEntries_leaveCategory; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_TimeEntries_leaveCategory" AS ENUM (
    'te-lc-annual',
    'te-lc-sick',
    'te-lc-admin',
    'te-lc-comp',
    'te-lc-without-pay',
    'te-lc-without-other'
);


ALTER TYPE "enum_TimeEntries_leaveCategory" OWNER TO dmitru;

--
-- Name: enum_TimeEntries_proceedingsCategory; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_TimeEntries_proceedingsCategory" AS ENUM (
    'te-pc-judges',
    'te-pc-magistrate',
    'te-pc-other'
);


ALTER TYPE "enum_TimeEntries_proceedingsCategory" OWNER TO dmitru;

--
-- Name: enum_Users_accountType; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Users_accountType" AS ENUM (
    'account-type-standard',
    'account-type-federal'
);


ALTER TYPE "enum_Users_accountType" OWNER TO dmitru;

--
-- Name: enum_Users_billingPeriod; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Users_billingPeriod" AS ENUM (
    'monthly',
    'yearly'
);


ALTER TYPE "enum_Users_billingPeriod" OWNER TO dmitru;

--
-- Name: enum_Users_subscriptionPlan; Type: TYPE; Schema: public; Owner: dmitru
--

CREATE TYPE "enum_Users_subscriptionPlan" AS ENUM (
    'V3_Monthly',
    'V3_Monthly_Catalyst',
    'V3_Yearly',
    'V3_Yearly_Catalyst'
);


ALTER TYPE "enum_Users_subscriptionPlan" OWNER TO dmitru;



--
-- Name: AttendanceCities; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "AttendanceCities" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE "AttendanceCities" OWNER TO dmitru;

--
-- Name: AttendanceCities_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "AttendanceCities_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "AttendanceCities_id_seq" OWNER TO dmitru;

--
-- Name: AttendanceCities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmitru
--

ALTER SEQUENCE "AttendanceCities_id_seq" OWNED BY "AttendanceCities".id;


--
-- Name: CaseLogEntries_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "CaseLogEntries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "CaseLogEntries_id_seq" OWNER TO dmitru;

--
-- Name: CaseLogEntries; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "CaseLogEntries" (
    id integer DEFAULT nextval('"CaseLogEntries_id_seq"'::regclass) NOT NULL,
    "dateStart" date NOT NULL,
    "dateEnd" date NOT NULL,
    "caseNumber" character varying(255),
    "exhibitCount" integer,
    "attorneysPresent" text,
    "otherAttendees" text,
    witnesses text,
    "witnessTranscriptReview" text,
    "requestedTranscriptFormat" text,
    notes text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer,
    "pageCount" integer
);


ALTER TABLE "CaseLogEntries" OWNER TO dmitru;

--
-- Name: ConfigValues; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "ConfigValues" (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    comment text
);


ALTER TABLE "ConfigValues" OWNER TO dmitru;

--
-- Name: ConfigValues_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "ConfigValues_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ConfigValues_id_seq" OWNER TO dmitru;

--
-- Name: ConfigValues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmitru
--

ALTER SEQUENCE "ConfigValues_id_seq" OWNED BY "ConfigValues".id;


--
-- Name: Customers_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "Customers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Customers_id_seq" OWNER TO dmitru;

--
-- Name: Customers; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "Customers" (
    id integer DEFAULT nextval('"Customers_id_seq"'::regclass) NOT NULL,
    type "enum_Customers_type",
    "firstName" character varying(255),
    "middleName" character varying(255),
    "lastName" character varying(255),
    suffix character varying(255),
    phone character varying(255),
    fax character varying(255),
    email character varying(255),
    "assistantName" character varying(255),
    "assistantEmail" character varying(255),
    "assistantPhone" character varying(255),
    "assistantFax" character varying(255),
    address character varying(255),
    "addressCont" character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    notes text,
    "firmName" character varying(255),
    "contactFirstName" character varying(255),
    "contactLastName" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "firmId" integer,
    "userId" integer,
    "reporterSuiteUserId" integer,
    prefix character varying(255),
    "ratesPagesStateStandard" integer,
    "ratesPagesStateExpedited" integer,
    "ratesPagesStateDaily" integer,
    "ratesPagesStateRealtime" integer,
    "ratesPagesStateRoughCopy" integer,
    "ratesPagesStateCopy" integer,
    "ratesPagesProofreading" integer,
    "ratesPagesProofreadingRush" integer,
    "ratesPagesProofreadingDaily" integer,
    "ratesPagesScoping" integer,
    "ratesPagesScopingRush" integer,
    "ratesPagesScopingDaily" integer,
    "ratesHoursProofreading" integer,
    "ratesHoursProofreadingRush" integer,
    "ratesHoursProofreadingDaily" integer,
    "ratesHoursScoping" integer,
    "ratesHoursScopingRush" integer,
    "ratesHoursScopingDaily" integer
);


ALTER TABLE "Customers" OWNER TO dmitru;

--
-- Name: ExpenseCategories_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "ExpenseCategories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ExpenseCategories_id_seq" OWNER TO dmitru;

--
-- Name: ExpenseCategories; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "ExpenseCategories" (
    id integer DEFAULT nextval('"ExpenseCategories_id_seq"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    "isBuiltIn" boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE "ExpenseCategories" OWNER TO dmitru;

--
-- Name: ExpenseEntries_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "ExpenseEntries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ExpenseEntries_id_seq" OWNER TO dmitru;

--
-- Name: ExpenseEntries; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "ExpenseEntries" (
    id integer DEFAULT nextval('"ExpenseEntries_id_seq"'::regclass) NOT NULL,
    amount integer NOT NULL,
    date date NOT NULL,
    "invoiceNumber" character varying(255),
    type "enum_ExpenseEntries_type" NOT NULL,
    "paymentType" character varying(255),
    itemization text,
    notes text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer,
    "categoryId" integer,
    "payeeId" integer
);


ALTER TABLE "ExpenseEntries" OWNER TO dmitru;

--
-- Name: InvoiceItems_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "InvoiceItems_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "InvoiceItems_id_seq" OWNER TO dmitru;

--
-- Name: InvoiceItems; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "InvoiceItems" (
    id integer DEFAULT nextval('"InvoiceItems_id_seq"'::regclass) NOT NULL,
    date date,
    trial character varying(255),
    type character varying(255),
    hours integer,
    pages integer,
    "hoursRate" integer,
    "pagesRate" integer,
    total integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "invoiceId" integer,
    fee integer
);


ALTER TABLE "InvoiceItems" OWNER TO dmitru;

--
-- Name: InvoiceTemplateProofreadingAndScopings_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "InvoiceTemplateProofreadingAndScopings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "InvoiceTemplateProofreadingAndScopings_id_seq" OWNER TO dmitru;

--
-- Name: InvoiceTemplateProofreadingAndScopings; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "InvoiceTemplateProofreadingAndScopings" (
    id integer DEFAULT nextval('"InvoiceTemplateProofreadingAndScopings_id_seq"'::regclass) NOT NULL,
    "showInvoiceNumber" boolean DEFAULT true,
    "showInvoiceDate" boolean DEFAULT true,
    "showSignature" boolean DEFAULT true,
    "showType" boolean DEFAULT true,
    "showHourCount" boolean DEFAULT true,
    "showHourRate" boolean DEFAULT true,
    "showPageCount" boolean DEFAULT true,
    "showPageRate" boolean DEFAULT true,
    "showAdditionalTerms" boolean DEFAULT true,
    "showDescription" boolean DEFAULT true,
    "showNotes" boolean DEFAULT true,
    "showReceipientName" boolean DEFAULT true,
    "showReceipientSuffix" boolean DEFAULT true,
    "showReceipientAddress" boolean DEFAULT true,
    "showReceipientPhone" boolean DEFAULT true,
    "showReceipientFax" boolean DEFAULT true,
    "showReceipientEmail" boolean DEFAULT true,
    "showReceipientRSProfile" boolean DEFAULT true,
    "showSenderName" boolean DEFAULT true,
    "showSenderSuffix" boolean DEFAULT true,
    "showSenderAddress" boolean DEFAULT true,
    "showSenderPhone" boolean DEFAULT true,
    "showSenderFax" boolean DEFAULT true,
    "showSenderEmail" boolean DEFAULT true,
    "showSenderRSProfile" boolean DEFAULT true,
    "showTrial" boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE "InvoiceTemplateProofreadingAndScopings" OWNER TO dmitru;

--
-- Name: InvoiceTemplateStateAndFreelances_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "InvoiceTemplateStateAndFreelances_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "InvoiceTemplateStateAndFreelances_id_seq" OWNER TO dmitru;

--
-- Name: InvoiceTemplateStateAndFreelances; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "InvoiceTemplateStateAndFreelances" (
    id integer DEFAULT nextval('"InvoiceTemplateStateAndFreelances_id_seq"'::regclass) NOT NULL,
    "showInvoiceNumber" boolean DEFAULT true,
    "showInvoiceDate" boolean DEFAULT true,
    "showSignature" boolean DEFAULT true,
    "showPageCount" boolean DEFAULT true,
    "showPageRate" boolean DEFAULT true,
    "showPageType" boolean DEFAULT true,
    "showTranscribersCSROrId" boolean DEFAULT true,
    "showBillableLineItemCode" boolean DEFAULT true,
    "showReceipientName" boolean DEFAULT true,
    "showReceipientSuffix" boolean DEFAULT true,
    "showReceipientFirmName" boolean DEFAULT true,
    "showReceipientAddress" boolean DEFAULT true,
    "showReceipientPhone" boolean DEFAULT true,
    "showReceipientFax" boolean DEFAULT true,
    "showReceipientEmail" boolean DEFAULT true,
    "showReceipientAssistantsName" boolean DEFAULT true,
    "showReceipientAssistantsPhone" boolean DEFAULT true,
    "showReceipientAssistantsFax" boolean DEFAULT true,
    "showReceipientAssistantsEmail" boolean DEFAULT true,
    "showReporterName" boolean DEFAULT true,
    "showReporterSuffix" boolean DEFAULT true,
    "showReporterAddress" boolean DEFAULT true,
    "showReporterPhone" boolean DEFAULT true,
    "showReporterFax" boolean DEFAULT true,
    "showReporterEmail" boolean DEFAULT true,
    "showReporterRSProfile" boolean DEFAULT true,
    "showCourthouse" boolean DEFAULT true,
    "showProceedingType" boolean DEFAULT true,
    "showProceedingDate" boolean DEFAULT true,
    "showCaseNumber" boolean DEFAULT true,
    "showCaseCaption" boolean DEFAULT true,
    "showTranscriptRequestedBy" boolean DEFAULT true,
    "showJudgeHearingCase" boolean DEFAULT true,
    "showTranscriptOrderedOn" boolean DEFAULT true,
    "showTranscriptDeliveredOn" boolean DEFAULT true,
    "showAdditionalTerms" boolean DEFAULT true,
    "showDescription" boolean DEFAULT true,
    "showNotes" boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer,
    "showApprovedBy" boolean DEFAULT false
);


ALTER TABLE "InvoiceTemplateStateAndFreelances" OWNER TO dmitru;

--
-- Name: Invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "Invoices_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Invoices_id_seq" OWNER TO dmitru;

--
-- Name: Invoices; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "Invoices" (
    id integer DEFAULT nextval('"Invoices_id_seq"'::regclass) NOT NULL,
    "sharedLinkToken" character varying(255),
    "invoiceNumber" character varying(255) NOT NULL,
    "canBePaidWithStripe" boolean DEFAULT true,
    "stripeFeePaidBySender" boolean DEFAULT false,
    "stripeChargeData" jsonb,
    date date NOT NULL,
    "transcriptOrderedOn" date,
    "transcriptDeliveredOn" date,
    type "enum_Invoices_type" NOT NULL,
    "recipientType" "enum_Invoices_recipientType",
    "caseType" "enum_Invoices_caseType",
    "realtimeProvided" "enum_Invoices_realtimeProvided",
    "caseNumber" character varying(255),
    plaintiff character varying(255),
    defendant character varying(255),
    description text,
    notes text,
    "proceedingsDate" date,
    "judgeHearingCase" character varying(255),
    courthouse character varying(255),
    "transcriptOrderedBy" character varying(255),
    "dcnClassification" character varying(255),
    "appealCaNumber" character varying(255),
    "accountingType" "enum_Invoices_accountingType",
    "customerFirmName" character varying(255),
    "customerFirstName" character varying(255),
    "customerLastName" character varying(255),
    "customerMiddleName" character varying(255),
    "customerSuffix" character varying(255),
    "customerAddress" character varying(255),
    "customerAddressCont" character varying(255),
    "customerCity" character varying(255),
    "customerState" character varying(255),
    "customerZip" character varying(255),
    "customerPhone" character varying(255),
    "customerEmail" character varying(255),
    "customerFax" character varying(255),
    "customerAssistantName" character varying(255),
    "customerAssistantEmail" character varying(255),
    "customerAssistantPhone" character varying(255),
    "customerAssistantFax" character varying(255),
    "ratesOrdinaryOriginal" integer DEFAULT 0,
    "ratesOrdinary1stCopy" integer DEFAULT 0,
    "ratesOrdinary2ndCopy" integer DEFAULT 0,
    "rates14DayOriginal" integer DEFAULT 0,
    "rates14Day1stCopy" integer DEFAULT 0,
    "rates14Day2ndCopy" integer DEFAULT 0,
    "ratesExpeditedOriginal" integer DEFAULT 0,
    "ratesExpedited1stCopy" integer DEFAULT 0,
    "ratesExpedited2ndCopy" integer DEFAULT 0,
    "ratesDailyOriginal" integer DEFAULT 0,
    "ratesDaily1stCopy" integer DEFAULT 0,
    "ratesDaily2ndCopy" integer DEFAULT 0,
    "ratesHourlyOriginal" integer DEFAULT 0,
    "ratesHourly1stCopy" integer DEFAULT 0,
    "ratesHourly2ndCopy" integer DEFAULT 0,
    "ratesRealtimeOriginal" integer DEFAULT 0,
    "ratesRealtime1stCopy" integer DEFAULT 0,
    "ratesRealtime2ndCopy" integer DEFAULT 0,
    "pagesOrdinaryOriginal" integer DEFAULT 0,
    "pagesOrdinary1stCopy" integer DEFAULT 0,
    "pagesOrdinary2ndCopy" integer DEFAULT 0,
    "pages14DayOriginal" integer DEFAULT 0,
    "pages14Day1stCopy" integer DEFAULT 0,
    "pages14Day2ndCopy" integer DEFAULT 0,
    "pagesExpeditedOriginal" integer DEFAULT 0,
    "pagesExpedited1stCopy" integer DEFAULT 0,
    "pagesExpedited2ndCopy" integer DEFAULT 0,
    "pagesDailyOriginal" integer DEFAULT 0,
    "pagesDaily1stCopy" integer DEFAULT 0,
    "pagesDaily2ndCopy" integer DEFAULT 0,
    "pagesHourlyOriginal" integer DEFAULT 0,
    "pagesHourly1stCopy" integer DEFAULT 0,
    "pagesHourly2ndCopy" integer DEFAULT 0,
    "pagesRealtimeOriginal" integer DEFAULT 0,
    "pagesRealtime1stCopy" integer DEFAULT 0,
    "pagesRealtime2ndCopy" integer DEFAULT 0,
    "lateDiscount" integer DEFAULT 0,
    total integer DEFAULT 0,
    "totalDue" integer DEFAULT 0,
    "depositCheckDate" date,
    "refundCheckDate" date,
    "paidCheckDate" date,
    "depositCheckNumber" character varying(255),
    "refundCheckNumber" character varying(255),
    "paidCheckNumber" character varying(255),
    "depositAmount" integer DEFAULT 0,
    "refundAmount" integer DEFAULT 0,
    "paidAmount" integer DEFAULT 0,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer,
    "customerId" integer,
    "customerFirmId" integer,
    "customerPrefix" character varying(255),
    "customerFirmContactFirstName" character varying(255),
    "customerFirmContactLastName" character varying(255),
    "customerFirmEmail" character varying(255),
    "customerFirmPhone" character varying(255),
    "customerFirmFax" character varying(255),
    "customerFirmAddress" character varying(255),
    "customerFirmAddressCont" character varying(255),
    "customerFirmState" character varying(255),
    "customerFirmCity" character varying(255),
    "customerFirmZip" character varying(255),
    "postageAmount" integer DEFAULT 0,
    re character varying(255),
    "taxRate" integer DEFAULT 0,
    "caseTitle" text
);


ALTER TABLE "Invoices" OWNER TO dmitru;

--
-- Name: Notifications; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "Notifications" (
    id integer NOT NULL,
    "userId" integer,
    "invoiceId" integer,
    title text,
    body text,
    date timestamp with time zone NOT NULL,
    type "enum_Notifications_type" NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "invoiceSharedLinkToken" character varying(255)
);


ALTER TABLE "Notifications" OWNER TO dmitru;

--
-- Name: Notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "Notifications_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Notifications_id_seq" OWNER TO dmitru;

--
-- Name: Notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmitru
--

ALTER SEQUENCE "Notifications_id_seq" OWNED BY "Notifications".id;


--
-- Name: Payees; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "Payees" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "accountNumber" character varying(255),
    "contactName" character varying(255),
    phone character varying(255),
    fax character varying(255),
    email character varying(255),
    website character varying(255),
    address character varying(255),
    "addressCont" character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    notes text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE "Payees" OWNER TO dmitru;

--
-- Name: Payees_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "Payees_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Payees_id_seq" OWNER TO dmitru;

--
-- Name: Payees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmitru
--

ALTER SEQUENCE "Payees_id_seq" OWNED BY "Payees".id;


--
-- Name: SentEmails_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "SentEmails_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "SentEmails_id_seq" OWNER TO dmitru;

--
-- Name: SentEmails; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "SentEmails" (
    id integer DEFAULT nextval('"SentEmails_id_seq"'::regclass) NOT NULL,
    type "enum_SentEmails_type" NOT NULL,
    "dateSent" timestamp with time zone NOT NULL,
    receipient character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "invoiceId" integer
);


ALTER TABLE "SentEmails" OWNER TO dmitru;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE "SequelizeMeta" OWNER TO dmitru;

--
-- Name: TimeCategories_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "TimeCategories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TimeCategories_id_seq" OWNER TO dmitru;

--
-- Name: TimeCategories; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "TimeCategories" (
    id integer DEFAULT nextval('"TimeCategories_id_seq"'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    "isBuiltIn" boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE "TimeCategories" OWNER TO dmitru;

--
-- Name: TimeEntries; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "TimeEntries" (
    id integer NOT NULL,
    city character varying(255),
    date date,
    "judgeInitials" character varying(255),
    "estimatedRealtimePageCount" integer,
    "minutesTracked" integer NOT NULL,
    notes text,
    "substituteReporterName" character varying(255),
    "travelMilage" integer,
    "leaveCategory" "enum_TimeEntries_leaveCategory",
    "proceedingsCategory" "enum_TimeEntries_proceedingsCategory",
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer,
    "categoryId" integer,
    "caseName" text,
    "caseNumber" text,
    "reportingOtherToWhom" text,
    "estimatedStandardPageCount" integer
);


ALTER TABLE "TimeEntries" OWNER TO dmitru;

--
-- Name: TimeEntries_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "TimeEntries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "TimeEntries_id_seq" OWNER TO dmitru;

--
-- Name: TimeEntries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmitru
--

ALTER SEQUENCE "TimeEntries_id_seq" OWNED BY "TimeEntries".id;


--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: dmitru
--

CREATE SEQUENCE "Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Users_id_seq" OWNER TO dmitru;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: dmitru
--

CREATE TABLE "Users" (
    id integer DEFAULT nextval('"Users_id_seq"'::regclass) NOT NULL,
    "accountType" "enum_Users_accountType",
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    suffix character varying(255),
    email character varying(255) NOT NULL,
    password character varying(255),
    "passwordResetToken" character varying(255),
    "passwordResetTokenExpires" timestamp with time zone,
    "stripeCustomerId" character varying(255),
    "stripeSubscriptionId" character varying(255),
    "stripeUserId" character varying(255),
    "stripeUserRefreshToken" character varying(255),
    "signupCompleted" boolean DEFAULT false,
    "googleAccountEmail" character varying(255),
    "federalEmployeeId" character varying(255),
    "federalOfficialDutyStation" character varying(255),
    district character varying(255),
    county character varying(255),
    "branchNumber" character varying(255),
    "einNumber" character varying(255),
    "socialSecurityNumber" character varying(255),
    "companyName" character varying(255),
    "companyWebsite" character varying(255),
    address character varying(255),
    "addressCont" character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    phone character varying(255),
    fax character varying(255),
    "additionalPaymentTerms" text,
    "avatarUrl" character varying(255),
    "avatarBucket" character varying(255),
    "avatarKey" character varying(255),
    "profileCertifications" text[],
    "profileWelcomeMessage" text,
    "profileShowContactInfo" boolean DEFAULT true,
    "profileShowContactForm" boolean DEFAULT true,
    "profileShowTranscriptRequestForm" boolean DEFAULT true,
    "ratesCivilPrivateOrdinaryOriginal" integer,
    "ratesCivilPrivateOrdinary1stCopy" integer,
    "ratesCivilPrivateOrdinary2ndCopy" integer,
    "ratesCivilPrivate14DayOriginal" integer,
    "ratesCivilPrivate14Day1stCopy" integer,
    "ratesCivilPrivate14Day2ndCopy" integer,
    "ratesCivilPrivateExpeditedOriginal" integer,
    "ratesCivilPrivateExpedited1stCopy" integer,
    "ratesCivilPrivateExpedited2ndCopy" integer,
    "ratesCivilPrivateDailyOriginal" integer,
    "ratesCivilPrivateDaily1stCopy" integer,
    "ratesCivilPrivateDaily2ndCopy" integer,
    "ratesCivilPrivateHourlyOriginal" integer,
    "ratesCivilPrivateHourly1stCopy" integer,
    "ratesCivilPrivateHourly2ndCopy" integer,
    "ratesCivilPrivateRealtimeOriginal" integer,
    "ratesCivilPrivateRealtime1stCopy" integer,
    "ratesCivilPrivateRealtime2ndCopy" integer,
    "ratesCivilOfficialOrdinaryOriginal" integer,
    "ratesCivilOfficialOrdinary1stCopy" integer,
    "ratesCivilOfficialOrdinary2ndCopy" integer,
    "ratesCivilOfficial14DayOriginal" integer,
    "ratesCivilOfficial14Day1stCopy" integer,
    "ratesCivilOfficial14Day2ndCopy" integer,
    "ratesCivilOfficialExpeditedOriginal" integer,
    "ratesCivilOfficialExpedited1stCopy" integer,
    "ratesCivilOfficialExpedited2ndCopy" integer,
    "ratesCivilOfficialDailyOriginal" integer,
    "ratesCivilOfficialDaily1stCopy" integer,
    "ratesCivilOfficialDaily2ndCopy" integer,
    "ratesCivilOfficialHourlyOriginal" integer,
    "ratesCivilOfficialHourly1stCopy" integer,
    "ratesCivilOfficialHourly2ndCopy" integer,
    "ratesCivilOfficialRealtimeOriginal" integer,
    "ratesCivilOfficialRealtime1stCopy" integer,
    "ratesCivilOfficialRealtime2ndCopy" integer,
    "ratesCriminalPrivateOrdinaryOriginal" integer,
    "ratesCriminalPrivateOrdinary1stCopy" integer,
    "ratesCriminalPrivateOrdinary2ndCopy" integer,
    "ratesCriminalPrivate14DayOriginal" integer,
    "ratesCriminalPrivate14Day1stCopy" integer,
    "ratesCriminalPrivate14Day2ndCopy" integer,
    "ratesCriminalPrivateExpeditedOriginal" integer,
    "ratesCriminalPrivateExpedited1stCopy" integer,
    "ratesCriminalPrivateExpedited2ndCopy" integer,
    "ratesCriminalPrivateDailyOriginal" integer,
    "ratesCriminalPrivateDaily1stCopy" integer,
    "ratesCriminalPrivateDaily2ndCopy" integer,
    "ratesCriminalPrivateHourlyOriginal" integer,
    "ratesCriminalPrivateHourly1stCopy" integer,
    "ratesCriminalPrivateHourly2ndCopy" integer,
    "ratesCriminalPrivateRealtimeOriginal" integer,
    "ratesCriminalPrivateRealtime1stCopy" integer,
    "ratesCriminalPrivateRealtime2ndCopy" integer,
    "ratesCriminalOfficialOrdinaryOriginal" integer,
    "ratesCriminalOfficialOrdinary1stCopy" integer,
    "ratesCriminalOfficialOrdinary2ndCopy" integer,
    "ratesCriminalOfficial14DayOriginal" integer,
    "ratesCriminalOfficial14Day1stCopy" integer,
    "ratesCriminalOfficial14Day2ndCopy" integer,
    "ratesCriminalOfficialExpeditedOriginal" integer,
    "ratesCriminalOfficialExpedited1stCopy" integer,
    "ratesCriminalOfficialExpedited2ndCopy" integer,
    "ratesCriminalOfficialDailyOriginal" integer,
    "ratesCriminalOfficialDaily1stCopy" integer,
    "ratesCriminalOfficialDaily2ndCopy" integer,
    "ratesCriminalOfficialHourlyOriginal" integer,
    "ratesCriminalOfficialHourly1stCopy" integer,
    "ratesCriminalOfficialHourly2ndCopy" integer,
    "ratesCriminalOfficialRealtimeOriginal" integer,
    "ratesCriminalOfficialRealtime1stCopy" integer,
    "ratesCriminalOfficialRealtime2ndCopy" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "middleName" character varying(255),
    prefix character varying(255),
    "ratesPagesProofreading" integer,
    "ratesPagesProofreadingRush" integer,
    "ratesPagesProofreadingDaily" integer,
    "ratesPagesScoping" integer,
    "ratesPagesScopingRush" integer,
    "ratesPagesScopingDaily" integer,
    "ratesHoursProofreading" integer,
    "ratesHoursProofreadingRush" integer,
    "ratesHoursProofreadingDaily" integer,
    "ratesHoursScoping" integer,
    "ratesHoursScopingRush" integer,
    "ratesHoursScopingDaily" integer,
    "lastSeenNotificationId" integer DEFAULT 0 NOT NULL,
    "ratesPagesStateExpedited" integer,
    "ratesPagesStateStandard" integer,
    "ratesPagesStateDaily" integer,
    "ratesPagesStateRealtime" integer,
    "ratesPagesStateRoughCopy" integer,
    "ratesPagesStateCopy" integer,
    "isAdmin" boolean DEFAULT false,
    "taxRate" integer,
    "billingPeriod" "enum_Users_billingPeriod",
    "subscriptionPlan" "enum_Users_subscriptionPlan",
    "federalInvoiceTitle" text DEFAULT 'Official US Court Reporter'::text,
    "notificationsInvoicePaymentReceived" boolean DEFAULT true,
    "notificationsIncomingInvoice" boolean DEFAULT true
);


ALTER TABLE "Users" OWNER TO dmitru;

--
-- Name: AttendanceCities id; Type: DEFAULT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "AttendanceCities" ALTER COLUMN id SET DEFAULT nextval('"AttendanceCities_id_seq"'::regclass);


--
-- Name: ConfigValues id; Type: DEFAULT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ConfigValues" ALTER COLUMN id SET DEFAULT nextval('"ConfigValues_id_seq"'::regclass);


--
-- Name: Notifications id; Type: DEFAULT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Notifications" ALTER COLUMN id SET DEFAULT nextval('"Notifications_id_seq"'::regclass);


--
-- Name: Payees id; Type: DEFAULT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Payees" ALTER COLUMN id SET DEFAULT nextval('"Payees_id_seq"'::regclass);


--
-- Name: TimeEntries id; Type: DEFAULT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "TimeEntries" ALTER COLUMN id SET DEFAULT nextval('"TimeEntries_id_seq"'::regclass);


--
-- Data for Name: AttendanceCities; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "AttendanceCities" (id, name, "createdAt", "updatedAt", "userId") FROM stdin;
3	Chicago	2017-07-21 15:52:11.573+03	2017-07-21 15:52:11.573+03	1
6	Chicago	2017-07-21 15:52:11.683+03	2017-07-21 15:52:11.683+03	2
10	Panama City	2017-07-27 18:56:50.124+03	2017-07-27 18:56:50.124+03	3
1	New York	2017-07-21 15:52:11.571+03	2017-07-21 15:52:11.571+03	1
4	New York	2017-07-21 15:52:11.573+03	2017-07-21 15:52:11.573+03	2
5	Boston	2017-07-21 15:52:11.578+03	2017-07-21 15:52:11.578+03	2
7	Tallahassee	2017-07-23 20:41:53.337+03	2017-07-23 20:41:53.337+03	2
8	Panama City	2017-07-23 20:41:59.149+03	2017-07-23 20:41:59.149+03	2
9	Tallahassee	2017-07-27 18:56:42.596+03	2017-07-27 18:56:42.596+03	3
12	Panama City	2017-07-27 20:54:16.037+03	2017-07-27 20:54:16.037+03	4
13	Pensacola	2017-07-27 20:54:24.82+03	2017-07-27 20:54:24.82+03	4
14	Gainesville	2017-07-27 20:54:30.393+03	2017-07-27 20:54:30.393+03	4
15	xxxx	2017-09-21 19:41:50.37+03	2017-09-21 19:41:50.37+03	1
16	sdf	2017-09-21 19:41:54.751+03	2017-09-21 19:41:54.751+03	1
2	Boston	2017-07-21 15:52:11.573+03	2017-07-21 15:52:11.573+03	1
11	Tallahassee	2017-07-27 19:24:46.07+03	2017-07-27 19:24:46.07+03	4
\.


--
-- Name: AttendanceCities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"AttendanceCities_id_seq"', 16, true);


--
-- Data for Name: CaseLogEntries; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "CaseLogEntries" (id, "dateStart", "dateEnd", "caseNumber", "exhibitCount", "attorneysPresent", "otherAttendees", witnesses, "witnessTranscriptReview", "requestedTranscriptFormat", notes, "createdAt", "updatedAt", "userId", "pageCount") FROM stdin;
2	2017-07-11	2017-07-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
6	2017-06-01	2017-06-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
10	2017-04-22	2017-04-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
16	2017-02-21	2017-02-24	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
21	2017-01-02	2017-01-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
26	2016-11-13	2016-11-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
31	2016-09-24	2016-09-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
36	2016-08-05	2016-08-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
41	2016-06-16	2016-06-19	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
46	2016-04-27	2016-05-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
51	2016-03-08	2016-03-08	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
56	2016-01-18	2016-01-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
61	2015-11-29	2015-12-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
66	2015-10-10	2015-10-10	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
71	2015-08-21	2015-08-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
75	2015-07-12	2015-07-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
85	2015-04-03	2015-04-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
90	2015-02-12	2015-02-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
100	2014-11-04	2014-11-08	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
105	2017-06-11	2017-06-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
110	2017-04-22	2017-04-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
115	2017-03-03	2017-03-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
120	2017-01-12	2017-01-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
123	2016-12-13	2016-12-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
129	2016-10-14	2016-10-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
135	2016-08-15	2016-08-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
140	2016-06-26	2016-06-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
145	2016-05-07	2016-05-12	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
150	2016-03-18	2016-03-21	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
156	2016-01-18	2016-01-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
161	2015-11-29	2015-12-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
166	2015-10-10	2015-10-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
171	2015-08-21	2015-08-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
176	2015-07-02	2015-07-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
181	2015-05-13	2015-05-13	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
186	2015-03-24	2015-03-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
191	2015-02-02	2015-02-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
196	2014-12-14	2014-12-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
201	2017-07-23	2017-07-26	876876	2	kjhkjh	kjhjk	\N	\N	\N	\N	2017-07-23 18:33:15.34+03	2017-07-23 18:33:15.34+03	2	\N
5	2017-06-11	2017-06-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
11	2017-04-12	2017-04-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
15	2017-03-03	2017-03-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
20	2017-01-12	2017-01-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
25	2016-11-23	2016-11-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
30	2016-10-04	2016-10-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
35	2016-08-15	2016-08-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
40	2016-06-26	2016-06-30	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
45	2016-05-07	2016-05-09	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
50	2016-03-18	2016-03-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
55	2016-01-28	2016-02-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
60	2015-12-09	2015-12-10	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
65	2015-10-20	2015-10-20	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
70	2015-08-31	2015-09-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
76	2015-07-02	2015-07-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
80	2015-05-23	2015-05-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
84	2015-04-13	2015-04-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
89	2015-02-22	2015-02-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
94	2015-01-03	2015-01-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
98	2014-11-24	2014-11-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
103	2017-07-01	2017-07-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
108	2017-05-12	2017-05-13	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
113	2017-03-23	2017-03-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
118	2017-02-01	2017-02-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
125	2016-11-23	2016-11-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
130	2016-10-04	2016-10-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
134	2016-08-25	2016-08-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
139	2016-07-06	2016-07-09	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
144	2016-05-17	2016-05-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
149	2016-03-28	2016-03-29	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
154	2016-02-07	2016-02-09	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
159	2015-12-19	2015-12-21	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
164	2015-10-30	2015-11-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
169	2015-09-10	2015-09-12	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
174	2015-07-22	2015-07-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
179	2015-06-02	2015-06-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
184	2015-04-13	2015-04-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
189	2015-02-22	2015-02-24	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
194	2015-01-03	2015-01-08	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
199	2014-11-14	2014-11-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
197	2014-12-04	2014-12-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
202	2017-07-30	2017-07-30	34562345	3	Brian Mason	\N	\N	\N	Realtime	\N	2017-07-30 18:03:23.563+03	2017-07-30 18:03:23.563+03	4	\N
200	2014-11-04	2014-11-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
203	2017-09-01	2017-09-20	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-21 19:50:56.82+03	2017-09-21 19:56:30.901+03	2	\N
3	2017-07-01	2017-07-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
7	2017-05-22	2017-05-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
12	2017-04-02	2017-04-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
17	2017-02-11	2017-02-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
22	2016-12-23	2016-12-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
27	2016-11-03	2016-11-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
32	2016-09-14	2016-09-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
37	2016-07-26	2016-07-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
42	2016-06-06	2016-06-09	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
47	2016-04-17	2016-04-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
52	2016-02-27	2016-03-02	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
57	2016-01-08	2016-01-10	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
62	2015-11-19	2015-11-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
67	2015-09-30	2015-10-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
72	2015-08-11	2015-08-12	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
77	2015-06-22	2015-06-24	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
82	2015-05-03	2015-05-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
87	2015-03-14	2015-03-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
92	2015-01-23	2015-01-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
97	2014-12-04	2014-12-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
101	2017-07-21	2017-07-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
106	2017-06-01	2017-06-02	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
111	2017-04-12	2017-04-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
117	2017-02-11	2017-02-11	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
122	2016-12-23	2016-12-27	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
127	2016-11-03	2016-11-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
132	2016-09-14	2016-09-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
137	2016-07-26	2016-07-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
142	2016-06-06	2016-06-11	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
147	2016-04-17	2016-04-21	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
152	2016-02-27	2016-02-29	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
158	2015-12-29	2016-01-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
163	2015-11-09	2015-11-12	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
168	2015-09-20	2015-09-24	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
173	2015-08-01	2015-08-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
178	2015-06-12	2015-06-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
183	2015-04-23	2015-04-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
188	2015-03-04	2015-03-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
193	2015-01-13	2015-01-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
198	2014-11-24	2014-11-29	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
4	2017-06-21	2017-06-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
8	2017-05-12	2017-05-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
13	2017-03-23	2017-03-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
18	2017-02-01	2017-02-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
23	2016-12-13	2016-12-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
29	2016-10-14	2016-10-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
33	2016-09-04	2016-09-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
38	2016-07-16	2016-07-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
43	2016-05-27	2016-05-29	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
48	2016-04-07	2016-04-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
53	2016-02-17	2016-02-18	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
58	2015-12-29	2016-01-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
63	2015-11-09	2015-11-10	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
68	2015-09-20	2015-09-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
74	2015-07-22	2015-07-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
79	2015-06-02	2015-06-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
81	2015-05-13	2015-05-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
86	2015-03-24	2015-03-27	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
91	2015-02-02	2015-02-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
95	2014-12-24	2014-12-29	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
99	2014-11-14	2014-11-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
104	2017-06-21	2017-06-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
109	2017-05-02	2017-05-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
114	2017-03-13	2017-03-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
119	2017-01-22	2017-01-27	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
126	2016-11-13	2016-11-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
131	2016-09-24	2016-09-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
136	2016-08-05	2016-08-10	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
141	2016-06-16	2016-06-21	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
146	2016-04-27	2016-04-30	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
151	2016-03-08	2016-03-12	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
155	2016-01-28	2016-01-29	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
160	2015-12-09	2015-12-13	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
165	2015-10-20	2015-10-25	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
170	2015-08-31	2015-09-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
175	2015-07-12	2015-07-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
180	2015-05-23	2015-05-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
185	2015-04-03	2015-04-08	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
190	2015-02-12	2015-02-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
195	2014-12-24	2014-12-28	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
1	2017-07-21	2017-07-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
9	2017-05-02	2017-05-06	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
14	2017-03-13	2017-03-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
19	2017-01-22	2017-01-27	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
24	2016-12-03	2016-12-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
28	2016-10-24	2016-10-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
34	2016-08-25	2016-08-27	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
39	2016-07-06	2016-07-09	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
44	2016-05-17	2016-05-21	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
49	2016-03-28	2016-04-01	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
54	2016-02-07	2016-02-09	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
59	2015-12-19	2015-12-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
64	2015-10-30	2015-11-03	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
69	2015-09-10	2015-09-12	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
73	2015-08-01	2015-08-02	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
78	2015-06-12	2015-06-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
83	2015-04-23	2015-04-26	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
88	2015-03-04	2015-03-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
93	2015-01-13	2015-01-14	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
96	2014-12-14	2014-12-16	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.746+03	2017-07-21 15:52:11.746+03	1	\N
102	2017-07-11	2017-07-13	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
107	2017-05-22	2017-05-23	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
112	2017-04-02	2017-04-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
116	2017-02-21	2017-02-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
121	2017-01-02	2017-01-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
124	2016-12-03	2016-12-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
128	2016-10-24	2016-10-24	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
133	2016-09-04	2016-09-05	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
138	2016-07-16	2016-07-17	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
143	2016-05-27	2016-05-31	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
148	2016-04-07	2016-04-07	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
153	2016-02-17	2016-02-22	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
157	2016-01-08	2016-01-10	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
162	2015-11-19	2015-11-19	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
167	2015-09-30	2015-10-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
172	2015-08-11	2015-08-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
177	2015-06-22	2015-06-24	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
182	2015-05-03	2015-05-04	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
187	2015-03-14	2015-03-15	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
192	2015-01-23	2015-01-27	CASE-123	3	Mr. Green, Mr. Brown	Mr. Blue, Mr. Black	Mr. Yellow, Mr. Red	An example review	An example transcript format	some notes	2017-07-21 15:52:11.819+03	2017-07-21 15:52:11.819+03	2	\N
\.


--
-- Name: CaseLogEntries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"CaseLogEntries_id_seq"', 203, true);


--
-- Data for Name: ConfigValues; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "ConfigValues" (id, key, value, comment) FROM stdin;
\.


--
-- Name: ConfigValues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"ConfigValues_id_seq"', 1, false);


--
-- Data for Name: Customers; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "Customers" (id, type, "firstName", "middleName", "lastName", suffix, phone, fax, email, "assistantName", "assistantEmail", "assistantPhone", "assistantFax", address, "addressCont", city, state, zip, notes, "firmName", "contactFirstName", "contactLastName", "createdAt", "updatedAt", "firmId", "userId", "reporterSuiteUserId", prefix, "ratesPagesStateStandard", "ratesPagesStateExpedited", "ratesPagesStateDaily", "ratesPagesStateRealtime", "ratesPagesStateRoughCopy", "ratesPagesStateCopy", "ratesPagesProofreading", "ratesPagesProofreadingRush", "ratesPagesProofreadingDaily", "ratesPagesScoping", "ratesPagesScopingRush", "ratesPagesScopingDaily", "ratesHoursProofreading", "ratesHoursProofreadingRush", "ratesHoursProofreadingDaily", "ratesHoursScoping", "ratesHoursScopingRush", "ratesHoursScopingDaily") FROM stdin;
1	ct-attorney	First Name	Middle Name	Last Name	Suffix	+12345	+12345	attorney@test.com	assistantName	assistant@test.com	+12345	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
20	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	ct-attorney	First Name	Middle Name	Last Name	Suffix	+12345	+12345	attorney@test.com	assistantName	assistant@test.com	+12345	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
28	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	ct-attorney	aaa	\N	zzz	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-23 01:16:21.34+03	2017-07-23 01:16:21.34+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	ct-law-firm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123 Adams Street	\N	Tallahassee	Florida	32301	\N	Smith & Jones	\N	\N	2017-07-23 17:55:59.702+03	2017-07-23 17:55:59.702+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	ct-law-firm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	101 East Main Street	\N	Tallahassee	Florida	32301	\N	Federal Public Defender's Office	\N	\N	2017-07-27 20:46:08.902+03	2017-07-27 20:46:08.902+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	ct-attorney	Richard	E.	Johnson	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-27 23:53:56.327+03	2017-07-27 23:53:56.327+03	49	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	ct-attorney	Barbara	Jean	Throne	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-28 00:05:52.505+03	2017-07-28 00:05:52.505+03	53	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	ct-reporter	Judy A.	\N	Gagnon	\N	(850) 561-6822	\N	judy.gagnon@reportersuite.com	\N	\N	\N	\N	111 North Adams Street	\N	Tallahassee	Florida	32301	\N	\N	\N	\N	2017-07-30 18:07:28.252+03	2017-07-30 18:07:28.252+03	\N	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	\N	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-09-20 13:53:16.799+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-09-20 13:53:37.754+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
18	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
22	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
30	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	ct-attorney	aaa	\N	zzz	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-23 01:16:25.103+03	2017-07-23 01:16:25.103+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	ct-law-firm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	101 East Main Street	\N	Tallahassee	Florida	32301	\N	Henry, Buchanan, Hudson, Suber & Carter, P.A.	\N	\N	2017-07-27 19:00:24.952+03	2017-07-27 19:00:24.952+03	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	ct-law-firm	\N	\N	\N	\N	(850) 123-4567	\N	\N	\N	\N	\N	\N	310 East Bradford Road	\N	Tallahassee	Florida	32317	\N	Marie Mattox, P.A.	\N	\N	2017-07-27 20:58:52.86+03	2017-07-27 21:02:23.953+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	ct-law-firm	\N	\N	\N	\N	(850) 675-0989	\N	\N	\N	\N	\N	\N	17451 Main Street North	\N	Blountstown	Florida	32325	\N	Chipola Law	\N	\N	2017-07-28 00:05:23.488+03	2017-07-28 00:05:23.488+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	ct-attorney	asdf	\N	asdfasdf	\N	\N	\N	asdfadsf@asdf.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-30 22:39:36.504+03	2017-07-30 22:39:36.504+03	47	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
21	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
26	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
29	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	ct-attorney	Paul	M.	Johnson	Attorney at Law	(850)561-6822	\N	pj@smith.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-23 20:03:50.686+03	2017-07-23 20:03:50.686+03	39	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	ct-attorney	Marie	\N	Mattox	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-27 20:59:15.645+03	2017-07-27 20:59:15.645+03	47	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	ct-attorney	Barbara	\N	Sanders	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-28 00:02:14.757+03	2017-07-28 00:02:14.757+03	51	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	ct-attorney	Jesse	\N	Jones	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-28 00:17:33.471+03	2017-07-28 00:17:33.471+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	ct-law-firm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sv	\N	\N	2017-09-14 21:47:21.481+03	2017-09-14 21:47:21.481+03	\N	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
23	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
31	ct-attorney	abc	\N	adf	def	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-23 01:15:56.03+03	2017-07-23 01:15:56.03+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	ct-law-firm	\N	\N	\N	\N	850123456	\N	sj@smith.com	\N	\N	\N	\N	123 Adams Street	\N	Tallahassee	Florida	32301	\N	Smith & Jones	\N	\N	2017-07-23 17:41:49.855+03	2017-07-23 17:41:49.855+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	ct-attorney	Carey	M	Jones	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-27 19:02:13.006+03	2017-07-27 19:02:13.006+03	43	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	ct-law-firm	\N	\N	\N	\N	850-425-1990	\N	\N	\N	\N	\N	\N	214 West Jefferson Street	\N	Tallahassee	Florida	32301	\N	Richard E. Johnson, P.A.	\N	\N	2017-07-27 23:53:56.211+03	2017-07-27 23:53:56.211+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	ct-attorney	Petra	\N	Jones	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-28 00:13:56.134+03	2017-07-28 00:13:56.134+03	55	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	ct-attorney	Michael	J	Ellan	\N	\N	\N	mike.ellan@gmail.com	\N	mike.ellan@gmail.com	\N	\N	67 Algonkin Rd.	\N	Jim Thorpe	PA	18229	\N	\N	\N	\N	2017-07-28 21:35:30.769+03	2017-07-28 21:36:17.007+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	ct-attorney	First Name	Middle Name	Last Name	Suffix	+12345	+12345	attorney@test.com	assistantName	assistant@test.com	+12345	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.971+03	2017-07-21 15:52:11.971+03	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
19	ct-law-firm	\N	\N	\N	\N	654321	654321	law-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Law Firm Name	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
24	ct-reporting-firm	\N	\N	\N	\N	98765	98765	reporting-firm@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	Reporting Firm Name	First Name	Last Name	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
27	ct-reporter	First Name	\N	Last Name	\N	8765	8765	reporter@test.com	\N	\N	\N	\N	address	addressCont	New York	New York	12345	Test notes	\N	\N	\N	2017-07-21 15:52:11.981+03	2017-07-21 15:52:11.981+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
32	ct-attorney	abc	\N	adf	def	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-23 01:16:02.268+03	2017-07-23 01:16:02.268+03	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	ct-attorney	Greg	M.	Johnson	Attorney at Law	8501235678	\N	greg@smith.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-23 17:55:59.823+03	2017-07-23 17:55:59.823+03	39	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	ct-attorney	Michelle	J	Smith	Attorney at Law	850-123-456	\N	michelle.smith@pd.gov	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-27 20:47:04.818+03	2017-07-27 20:47:04.818+03	45	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	ct-law-firm	\N	\N	\N	\N	(850) 653-8877	\N	bsanders@fairpoint.net	\N	\N	\N	\N	Post Office Box 157	\N	Apalachicola	Florida	32329	\N	Sanders and Duncan, P.A.	\N	\N	2017-07-28 00:01:37.782+03	2017-07-28 00:01:37.782+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	ct-law-firm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	National Center for Law and Economic Justice	\N	\N	2017-07-28 00:13:17.262+03	2017-07-28 00:13:17.262+03	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: Customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"Customers_id_seq"', 61, true);


--
-- Data for Name: ExpenseCategories; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "ExpenseCategories" (id, name, description, "isBuiltIn", "createdAt", "updatedAt", "userId") FROM stdin;
1	Substitute Reporters due to absense	\N	t	2017-07-21 15:52:11.243+03	2017-07-21 15:52:11.243+03	\N
3	Note Readers	\N	t	2017-07-21 15:52:11.25+03	2017-07-21 15:52:11.25+03	\N
6	Scopists	\N	t	2017-07-21 15:52:11.277+03	2017-07-21 15:52:11.277+03	\N
7	Other clerical personnel	\N	t	2017-07-21 15:52:11.278+03	2017-07-21 15:52:11.278+03	\N
11	Rent for office space (including utilities)	\N	t	2017-07-21 15:52:11.315+03	2017-07-21 15:52:11.315+03	\N
12	Rent for copy equipment	\N	t	2017-07-21 15:52:11.317+03	2017-07-21 15:52:11.317+03	\N
16	Postage expense	\N	t	2017-07-21 15:52:11.34+03	2017-07-21 15:52:11.34+03	\N
17	Telephone expense	\N	t	2017-07-21 15:52:11.345+03	2017-07-21 15:52:11.345+03	\N
21	Broadband	Internet Connection	f	2017-07-30 18:17:41.045+03	2017-07-30 18:17:41.045+03	4
22	Depreciation of equipment	\N	t	2017-07-30 18:17:41.045+03	2017-07-30 18:17:41.045+03	\N
27	dfsdf	\N	f	2017-09-20 15:43:53.77+03	2017-09-20 15:43:53.77+03	1
26	sdfsdfs	\N	f	2017-09-20 15:42:59.24+03	2017-09-20 15:42:59.24+03	1
4	Typists	\N	t	2017-07-21 15:52:11.251+03	2017-07-21 15:52:11.251+03	\N
8	Employer's contributions (FICA, etc.)	\N	t	2017-07-21 15:52:11.283+03	2017-07-21 15:52:11.283+03	\N
13	Rent for CAT equipment	\N	t	2017-07-21 15:52:11.318+03	2017-07-21 15:52:11.318+03	\N
18	Other communication expense (Specify)	\N	t	2017-07-21 15:52:11.345+03	2017-07-21 15:52:11.345+03	\N
5	Transcribers	\N	t	2017-07-21 15:52:11.251+03	2017-07-21 15:52:11.251+03	\N
9	Travel incident to private reporting activities	\N	t	2017-07-21 15:52:11.283+03	2017-07-21 15:52:11.283+03	\N
14	Other rent (Specify)	\N	t	2017-07-21 15:52:11.327+03	2017-07-21 15:52:11.327+03	\N
19	Supplies and materials	\N	t	2017-07-21 15:52:11.345+03	2017-07-21 15:52:11.345+03	\N
2	Substitute Reporters to assist with daily and hourly transcript	\N	t	2017-07-21 15:52:11.245+03	2017-07-21 15:52:11.245+03	\N
10	Travel by substitute reporters and other personnel	\N	t	2017-07-21 15:52:11.293+03	2017-07-21 15:52:11.293+03	\N
15	Equipment repair and maintenance	\N	t	2017-07-21 15:52:11.327+03	2017-07-21 15:52:11.327+03	\N
20	Other expenses (itemize all claimed)	\N	t	2017-07-21 15:52:11.35+03	2017-07-21 15:52:11.35+03	\N
\.


--
-- Name: ExpenseCategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"ExpenseCategories_id_seq"', 27, true);


--
-- Data for Name: ExpenseEntries; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "ExpenseEntries" (id, amount, date, "invoiceNumber", type, "paymentType", itemization, notes, "createdAt", "updatedAt", "userId", "categoryId", "payeeId") FROM stdin;
6	28848	2017-07-16	INV-28154	et-government	VISA	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
5	15825	2017-07-17	INV-61170	et-government	By Check	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	16	\N
10	69711	2017-07-12	INV-97333	et-government	By Check	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
12	16220	2017-07-10	INV-49315	et-private	Bank Transfer	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	12	\N
13	94881	2017-07-09	INV-18055	et-private	By Check	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
14	76059	2017-07-08	INV-89632	et-private	By Check	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
16	48824	2017-07-06	INV-58005	et-private	VISA	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
31	62570	2017-06-21	INV-41168	et-government	Bank Transfer	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	3	\N
36	55905	2017-06-16	INV-15093	et-government	Bank Transfer	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
43	81814	2017-06-09	INV-2241	et-private	By Check	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
45	6445	2017-06-07	INV-75404	et-government	VISA	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	9	\N
46	59468	2017-06-06	INV-48257	et-private	By Check	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	15	\N
49	14260	2017-06-03	INV-23300	et-private	By Check	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	7	\N
50	48096	2017-06-02	INV-49629	et-private	Bank Transfer	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
56	66904	2017-05-27	INV-24478	et-government	Bank Transfer	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	12	\N
63	8780	2017-05-20	INV-14068	et-private	Bank Transfer	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	17	\N
65	4492	2017-05-18	INV-31794	et-private	By Check	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
66	43206	2017-05-17	INV-77860	et-government	VISA	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
3	44834	2017-07-19	INV-18165	et-government	VISA	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	19	\N
90	89946	2017-04-23	INV-7223	et-government	VISA	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	11	\N
106	9334	2017-07-16	INV-75724	et-government	Bank Transfer	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	12	\N
116	20255	2017-07-06	INV-27825	et-government	By Check	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
121	40821	2017-07-01	INV-60400	et-government	By Check	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
131	25083	2017-06-21	INV-18200	et-private	VISA	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	2	\N
170	22852	2017-05-13	INV-45168	et-government	By Check	pens	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	10	\N
181	47905	2017-05-02	INV-11345	et-private	VISA	pens	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
195	30671	2017-04-18	INV-70399	et-private	Bank Transfer	antique typewriters	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	20	\N
156	51588	2017-05-27	INV-14317	et-government	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	11	\N
175	77012	2017-05-08	INV-52511	et-government	VISA	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
200	86598	2017-04-13	INV-97462	et-private	Bank Transfer	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	1	\N
126	39515	2017-06-26	INV-49987	et-private	By Check	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	15	\N
141	75320	2017-06-11	INV-2419	et-government	By Check	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	12	\N
151	93435	2017-06-01	INV-91635	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	3	\N
146	7407	2017-06-06	INV-18644	et-private	VISA	pens	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	14	\N
111	13927	2017-07-11	INV-52040	et-private	Bank Transfer	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	17	\N
161	23431	2017-05-22	INV-83222	et-private	VISA	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
191	46611	2017-04-22	INV-99358	et-government	VISA	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	10	\N
136	70841	2017-06-16	INV-97851	et-government	VISA	antique typewriters	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	2	\N
165	16629	2017-05-18	INV-63414	et-private	VISA	pens	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
186	11417	2017-04-27	INV-59803	et-government	By Check	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	9	\N
101	32842	2017-07-21	INV-38419	et-government	By Check	printers	\N	2017-07-21 15:52:11.934+03	2017-09-20 14:32:15.905+03	2	\N	\N
74	60052	2017-05-09	INV-31528	et-private	Bank Transfer	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	10	\N
96	68355	2017-04-17	INV-20579	et-private	By Check	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
69	93338	2017-05-14	INV-71568	et-government	By Check	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	6	\N
79	89310	2017-05-04	INV-58431	et-private	VISA	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
86	56923	2017-04-27	INV-35945	et-government	Bank Transfer	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	10	\N
87	2494	2017-04-26	INV-69539	et-government	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	17	\N
123	41651	2017-06-29	INV-80642	et-private	VISA	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
143	86811	2017-06-09	INV-55007	et-private	By Check	pens	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	18	\N
148	19781	2017-06-04	INV-68393	et-private	By Check	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
158	52456	2017-05-25	INV-66187	et-government	By Check	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
168	73572	2017-05-15	INV-33472	et-private	By Check	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	1	\N
102	58935	2017-07-20	INV-4632	et-private	By Check	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
133	53990	2017-06-19	INV-18830	et-private	Bank Transfer	antique typewriters	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
138	69071	2017-06-14	INV-39982	et-government	VISA	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	14	\N
178	20097	2017-05-05	INV-82078	et-private	Bank Transfer	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
113	2055	2017-07-09	INV-79521	et-government	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	1	\N
188	57672	2017-04-25	INV-83027	et-government	VISA	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
163	92604	2017-05-20	INV-9442	et-private	VISA	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
173	49237	2017-05-10	INV-12948	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	5	\N
183	54523	2017-04-30	INV-16509	et-private	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	19	\N
118	70724	2017-07-04	INV-22988	et-private	Bank Transfer	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
128	30799	2017-06-24	INV-27936	et-private	Bank Transfer	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	18	\N
198	50878	2017-04-15	INV-83401	et-private	VISA	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
108	57345	2017-07-14	INV-38197	et-government	Bank Transfer	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
193	12073	2017-04-20	INV-86750	et-government	VISA	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	1	\N
153	71227	2017-05-30	INV-9458	et-private	Bank Transfer	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
70	67635	2017-05-13	INV-69301	et-private	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	20	\N
75	31878	2017-05-08	INV-6734	et-government	By Check	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	1	\N
83	78567	2017-04-30	INV-47828	et-private	By Check	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	19	\N
92	11465	2017-04-21	INV-81618	et-government	VISA	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	15	\N
80	31955	2017-05-03	INV-4202	et-private	VISA	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	16	\N
97	79940	2017-04-16	INV-80065	et-private	VISA	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	12	\N
199	49190	2017-04-14	INV-77960	et-private	VISA	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
114	3413	2017-07-08	INV-59529	et-private	VISA	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	9	\N
119	37915	2017-07-03	INV-29875	et-private	Bank Transfer	pens	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
179	27518	2017-05-04	INV-9477	et-government	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	19	\N
189	40500	2017-04-24	INV-85517	et-government	VISA	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
154	4709	2017-05-29	INV-48091	et-government	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	6	\N
139	647	2017-06-13	INV-19000	et-private	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
104	42601	2017-07-18	INV-62217	et-private	Bank Transfer	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	11	\N
164	98548	2017-05-19	INV-7597	et-private	By Check	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
129	76508	2017-06-23	INV-81414	et-government	VISA	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	12	\N
134	27022	2017-06-18	INV-60574	et-government	VISA	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	20	\N
184	85266	2017-04-29	INV-85500	et-government	By Check	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	10	\N
159	1148	2017-05-24	INV-72567	et-private	By Check	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
144	55678	2017-06-08	INV-63352	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	4	\N
169	97400	2017-05-14	INV-21746	et-private	Bank Transfer	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	10	\N
109	18115	2017-07-13	INV-95236	et-private	By Check	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
124	84127	2017-06-28	INV-33314	et-private	Bank Transfer	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	2	\N
149	7361	2017-06-03	INV-21194	et-government	VISA	pens	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	18	\N
174	32755	2017-05-09	INV-79699	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	13	\N
194	25411	2017-04-19	INV-87354	et-government	Bank Transfer	antique typewriters	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
76	95276	2017-05-07	INV-56144	et-private	VISA	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	4	\N
89	79044	2017-04-24	INV-30639	et-government	By Check	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
84	36750	2017-04-29	INV-31070	et-private	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	2	\N
99	366	2017-04-14	INV-82226	et-government	By Check	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
81	44009	2017-05-02	INV-66750	et-government	By Check	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
94	50889	2017-04-19	INV-50352	et-private	Bank Transfer	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	7	\N
71	53322	2017-05-12	INV-89106	et-private	VISA	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	20	\N
77	9752	2017-05-06	INV-85533	et-private	VISA	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
98	40330	2017-04-15	INV-30340	et-private	Bank Transfer	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	8	\N
107	67182	2017-07-15	INV-2351	et-government	VISA	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	19	\N
112	463	2017-07-10	INV-94301	et-private	VISA	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	19	\N
117	68743	2017-07-05	INV-19589	et-private	By Check	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
122	21818	2017-06-30	INV-23197	et-government	Bank Transfer	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	15	\N
137	11387	2017-06-15	INV-50896	et-private	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
162	63101	2017-05-21	INV-2243	et-private	VISA	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
177	65688	2017-05-06	INV-30153	et-private	VISA	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
197	86812	2017-04-16	INV-54735	et-private	By Check	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
202	23500	2017-05-02	3456	et-government	\N	Software	\N	2017-07-27 21:04:30.808+03	2017-07-27 21:04:30.808+03	4	15	\N
132	78400	2017-06-20	INV-45316	et-government	Bank Transfer	pens	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
142	23241	2017-06-10	INV-49922	et-government	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	17	\N
157	10247	2017-05-26	INV-1599	et-government	VISA	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
127	26811	2017-06-25	INV-52977	et-government	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	5	\N
167	45093	2017-05-16	INV-86474	et-private	VISA	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
147	68246	2017-06-05	INV-68128	et-private	VISA	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	13	\N
182	19999	2017-05-01	INV-91500	et-government	VISA	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
103	74652	2017-07-19	INV-9483	et-private	By Check	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	11	\N
152	85920	2017-05-31	INV-4414	et-government	By Check	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	13	\N
172	70219	2017-05-11	INV-275	et-government	VISA	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	1	\N
187	86139	2017-04-26	INV-50293	et-government	Bank Transfer	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	19	\N
192	22351	2017-04-21	INV-54250	et-private	VISA	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
93	45633	2017-04-20	INV-7970	et-government	VISA	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
82	87672	2017-05-01	INV-47216	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	2	\N
88	57222	2017-04-25	INV-58229	et-private	By Check	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	3	\N
72	89780	2017-05-11	INV-63007	et-government	Bank Transfer	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	7	\N
100	49698	2017-04-13	INV-49417	et-private	Bank Transfer	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	11	\N
105	3445	2017-07-17	INV-74285	et-government	By Check	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	12	\N
125	75795	2017-06-27	INV-7505	et-government	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	8	\N
155	59348	2017-05-28	INV-59202	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
166	28358	2017-05-17	INV-89650	et-private	By Check	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	18	\N
171	14189	2017-05-12	INV-4387	et-private	By Check	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	19	\N
176	10077	2017-05-07	INV-66307	et-private	Bank Transfer	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	8	\N
185	51254	2017-04-28	INV-39922	et-government	By Check	office paper	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
201	13500	2017-06-07	12345	et-government	\N	\N	\N	2017-07-27 21:03:44.821+03	2017-07-27 21:03:44.821+03	4	19	\N
110	87205	2017-07-12	INV-53061	et-private	VISA	office paper	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
135	33937	2017-06-17	INV-78206	et-private	VISA	monitors	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	7	\N
180	80012	2017-05-03	INV-48746	et-government	By Check	printers	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	13	\N
115	15999	2017-07-07	INV-62704	et-government	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	3	\N
120	45226	2017-07-02	INV-30993	et-government	Bank Transfer	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	17	\N
130	6492	2017-06-22	INV-98706	et-private	By Check	pens	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	\N	\N
145	31550	2017-06-07	INV-9981	et-government	Bank Transfer	pens	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	16	\N
150	40874	2017-06-02	INV-37384	et-private	VISA	antique typewriters	some notes	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	10	\N
190	29636	2017-04-23	INV-62821	et-government	VISA	printers	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	5	\N
140	3306	2017-06-12	INV-65721	et-private	By Check	antique typewriters	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	1	\N
160	30368	2017-05-23	INV-6330	et-government	By Check	pens	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	18	\N
196	18999	2017-04-17	INV-42487	et-private	By Check	monitors	\N	2017-07-21 15:52:11.934+03	2017-07-21 15:52:11.934+03	2	13	\N
24	22045	2017-06-28	INV-9968	et-government	By Check	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	16	\N
64	44430	2017-05-19	INV-62776	et-government	Bank Transfer	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
1	14685	2017-07-21	INV-72720	et-government	By Check	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-09-20 15:30:29.451+03	1	7	\N
7	31329	2017-07-15	INV-97448	et-government	By Check	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
19	49832	2017-07-03	INV-9575	et-private	VISA	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	4	\N
40	25215	2017-06-12	INV-67083	et-government	By Check	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
51	33370	2017-06-01	INV-91236	et-government	VISA	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	17	\N
52	85682	2017-05-31	INV-7353	et-government	By Check	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
30	62901	2017-06-22	INV-42191	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
39	85968	2017-06-13	INV-71955	et-government	VISA	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
42	1583	2017-06-10	INV-55092	et-private	VISA	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
54	5791	2017-05-29	INV-58775	et-government	VISA	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	3	\N
55	1538	2017-05-28	INV-61848	et-private	By Check	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
59	61338	2017-05-24	INV-812	et-private	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
2	53926	2017-07-20	INV-31052	et-government	VISA	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	15	\N
8	24204	2017-07-14	INV-25494	et-government	VISA	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	19	\N
27	90758	2017-06-25	INV-97238	et-government	By Check	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	1	\N
34	83828	2017-06-18	INV-91047	et-private	VISA	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	14	\N
38	5435	2017-06-14	INV-56682	et-government	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
53	52485	2017-05-30	INV-4157	et-government	VISA	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	14	\N
60	82586	2017-05-23	INV-36666	et-private	By Check	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	11	\N
62	69040	2017-05-21	INV-57291	et-government	By Check	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	16	\N
67	34200	2017-05-16	INV-50260	et-government	By Check	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	8	\N
11	42950	2017-07-11	INV-47689	et-government	By Check	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
15	84848	2017-07-07	INV-14455	et-private	Bank Transfer	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	2	\N
23	98466	2017-06-29	INV-16852	et-government	By Check	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
25	55224	2017-06-27	INV-75104	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	2	\N
68	7048	2017-05-15	INV-77738	et-private	Bank Transfer	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	9	\N
85	93125	2017-04-28	INV-38411	et-private	VISA	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	14	\N
22	71439	2017-06-30	INV-70403	et-private	VISA	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	9	\N
33	70337	2017-06-19	INV-32440	et-government	Bank Transfer	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	6	\N
37	26177	2017-06-15	INV-4693	et-government	Bank Transfer	monitors	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
44	69085	2017-06-08	INV-10696	et-government	VISA	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
48	26148	2017-06-04	INV-829	et-private	Bank Transfer	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	20	\N
58	4980	2017-05-25	INV-85977	et-private	Bank Transfer	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	4	\N
91	48136	2017-04-22	INV-96965	et-government	VISA	office paper	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	1	\N
95	22196	2017-04-18	INV-37029	et-private	Bank Transfer	printers	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	15	\N
28	10117	2017-06-24	INV-86520	et-government	VISA	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
29	38327	2017-06-23	INV-98095	et-private	VISA	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	14	\N
47	7850	2017-06-05	INV-34980	et-government	Bank Transfer	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
61	73651	2017-05-22	INV-25124	et-government	By Check	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	8	\N
4	19776	2017-07-18	INV-5684	et-government	VISA	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	6	\N
17	43004	2017-07-05	INV-1926	et-government	Bank Transfer	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	11	\N
21	84975	2017-07-01	INV-17658	et-private	Bank Transfer	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	19	\N
26	48629	2017-06-26	INV-67693	et-private	By Check	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	19	\N
32	71805	2017-06-20	INV-65002	et-private	VISA	office paper	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
73	57677	2017-05-10	INV-57004	et-government	By Check	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	9	\N
9	46997	2017-07-13	INV-47646	et-government	By Check	pens	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	1	\N
57	76753	2017-05-26	INV-34244	et-private	By Check	antique typewriters	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
78	71512	2017-05-05	INV-24189	et-government	VISA	antique typewriters	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	15	\N
18	71115	2017-07-04	INV-48107	et-government	By Check	pens	\N	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	2	\N
20	92987	2017-07-02	INV-8676	et-private	VISA	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	15	\N
35	37109	2017-06-17	INV-78024	et-private	By Check	printers	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	18	\N
41	47648	2017-06-11	INV-29370	et-private	VISA	monitors	some notes	2017-07-21 15:52:11.881+03	2017-07-21 15:52:11.881+03	1	\N	\N
203	2000	2017-09-01	\N	et-government	\N	\N	\N	2017-09-20 15:49:13.634+03	2017-09-20 16:09:49.068+03	1	\N	29
\.


--
-- Name: ExpenseEntries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"ExpenseEntries_id_seq"', 203, true);


--
-- Data for Name: InvoiceItems; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "InvoiceItems" (id, date, trial, type, hours, pages, "hoursRate", "pagesRate", total, "createdAt", "updatedAt", "invoiceId", fee) FROM stdin;
2	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	3	183	578	187	35955	2017-07-21 15:52:12.227+03	2017-07-21 15:52:12.227+03	10	\N
6	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	2	8	1105	103	3034	2017-07-21 15:52:12.228+03	2017-07-21 15:52:12.228+03	12	\N
15	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	3	79	1201	123	13320	2017-07-21 15:52:12.284+03	2017-07-21 15:52:12.284+03	16	\N
20	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	2	180	463	14	3446	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	17	\N
25	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	4	29	447	168	6660	2017-07-21 15:52:12.348+03	2017-07-21 15:52:12.348+03	18	\N
30	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	1	195	1629	101	21324	2017-07-21 15:52:12.349+03	2017-07-21 15:52:12.349+03	20	\N
35	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	5	59	1777	116	15729	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	21	\N
40	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	1	151	244	94	14438	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	19	\N
45	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	4	190	749	25	7746	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	23	\N
50	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	5	10	417	18	2265	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	27	\N
55	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	6	84	1807	158	24114	2017-07-21 15:52:12.423+03	2017-07-21 15:52:12.423+03	28	\N
60	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	1	98	1316	180	18956	2017-07-21 15:52:12.425+03	2017-07-21 15:52:12.425+03	31	\N
74	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	5	23	1853	63	10714	2017-07-21 15:52:12.462+03	2017-07-21 15:52:12.462+03	35	\N
70	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	2	171	870	107	20037	2017-07-21 15:52:12.426+03	2017-07-21 15:52:12.426+03	29	\N
85	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	3	189	798	56	\N	2017-07-21 15:57:02.995+03	2017-07-21 15:57:03.015+03	34	\N
10	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	19594	2017-07-21 15:52:12.228+03	2017-09-19 23:39:30.319+03	\N	\N
65	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	0	83	1928	171	14193	2017-07-21 15:52:12.425+03	2017-09-21 22:23:15.64+03	\N	\N
67	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	1	99	1463	137	15026	2017-07-21 15:52:12.425+03	2017-09-21 22:23:15.64+03	\N	\N
4	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	0	11	636	144	1584	2017-07-21 15:52:12.227+03	2017-07-21 15:52:12.227+03	11	\N
8	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	5	46	961	12	5357	2017-07-21 15:52:12.228+03	2017-07-21 15:52:12.228+03	12	\N
13	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	1	160	1558	143	24438	2017-07-21 15:52:12.284+03	2017-07-21 15:52:12.284+03	15	\N
18	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	5	101	583	32	6147	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	16	\N
23	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	1	178	1070	114	21362	2017-07-21 15:52:12.348+03	2017-07-21 15:52:12.348+03	18	\N
28	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	2	35	31	126	4472	2017-07-21 15:52:12.349+03	2017-07-21 15:52:12.349+03	22	\N
33	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	5	108	1788	174	27732	2017-07-21 15:52:12.349+03	2017-07-21 15:52:12.349+03	20	\N
38	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	4	43	888	41	5315	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	21	\N
43	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	3	85	1014	57	7887	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	23	\N
48	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	3	90	1408	124	15384	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	27	\N
53	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	0	14	428	49	686	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	25	\N
58	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	4	39	858	96	7176	2017-07-21 15:52:12.424+03	2017-07-21 15:52:12.424+03	32	\N
63	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	6	78	1395	106	16638	2017-07-21 15:52:12.425+03	2017-07-21 15:52:12.425+03	31	\N
75	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	2	40	636	97	5152	2017-07-21 15:52:12.463+03	2017-07-21 15:52:12.463+03	36	\N
76	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	0	184	767	88	16192	2017-07-21 15:52:12.463+03	2017-07-21 15:52:12.463+03	36	\N
83	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	49	201	40	\N	2017-07-21 15:57:02.995+03	2017-07-21 15:57:03.015+03	34	\N
88	2017-07-30	\N	\N	\N	33	0	333	\N	2017-08-01 01:51:15.031+03	2017-08-01 01:52:43.119+03	\N	\N
68	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	46	316	161	8986	2017-07-21 15:52:12.425+03	2017-09-21 22:23:15.64+03	\N	\N
5	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	3	58	1125	19	4477	2017-07-21 15:52:12.227+03	2017-07-21 15:52:12.227+03	10	\N
9	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	0	167	122	84	14028	2017-07-21 15:52:12.228+03	2017-07-21 15:52:12.228+03	13	\N
14	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	1	193	5	184	35517	2017-07-21 15:52:12.284+03	2017-07-21 15:52:12.284+03	16	\N
19	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	1	111	917	70	8687	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	16	\N
24	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	1	20	847	151	3867	2017-07-21 15:52:12.348+03	2017-07-21 15:52:12.348+03	18	\N
29	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	2	51	981	59	4971	2017-07-21 15:52:12.349+03	2017-07-21 15:52:12.349+03	22	\N
34	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	1	187	1396	184	35804	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	21	\N
39	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	0	71	445	126	8946	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	19	\N
44	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	2	40	796	81	4832	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	23	\N
49	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	5	67	16	13	951	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	27	\N
54	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	0	28	909	154	4312	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	25	\N
59	2017-07-20	Good Guy vs. Bad Guys	Proofreading Rush	2	23	699	132	4434	2017-07-21 15:52:12.424+03	2017-07-21 15:52:12.424+03	31	\N
79	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	49	201	40	2965	2017-07-21 15:52:12.463+03	2017-07-21 15:57:02.982+03	\N	\N
71	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	5	94	741	17	5303	2017-07-21 15:52:12.462+03	2017-07-21 15:52:12.462+03	33	\N
80	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	3	189	798	56	12978	2017-07-21 15:52:12.463+03	2017-07-21 15:57:02.982+03	\N	\N
84	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	4	141	1505	198	\N	2017-07-21 15:57:02.995+03	2017-07-21 15:57:03.015+03	34	\N
89	2017-07-30	\N	\N	\N	33	0	333	\N	2017-08-01 01:52:43.123+03	2017-08-01 01:52:43.131+03	50	\N
64	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	6	62	628	113	10774	2017-07-21 15:52:12.425+03	2017-09-21 22:23:15.64+03	\N	\N
3	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	3	156	818	88	16182	2017-07-21 15:52:12.227+03	2017-07-21 15:52:12.227+03	10	\N
12	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	1	49	628	146	7782	2017-07-21 15:52:12.284+03	2017-07-21 15:52:12.284+03	15	\N
17	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	1	129	496	189	24877	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	16	\N
22	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	4	75	1128	34	7062	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	17	\N
27	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	2	153	782	62	11050	2017-07-21 15:52:12.348+03	2017-07-21 15:52:12.348+03	22	\N
32	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	1	197	876	102	20970	2017-07-21 15:52:12.349+03	2017-07-21 15:52:12.349+03	20	\N
37	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	3	158	1422	146	27334	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	21	\N
41	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	5	65	1100	10	6150	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	24	\N
46	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	1	91	1716	91	9997	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	26	\N
51	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	1	197	1402	99	20905	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	25	\N
56	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	1	171	85	94	16159	2017-07-21 15:52:12.424+03	2017-07-21 15:52:12.424+03	28	\N
61	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	1	23	1246	32	1982	2017-07-21 15:52:12.425+03	2017-07-21 15:52:12.425+03	31	\N
73	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	6	26	1432	132	12024	2017-07-21 15:52:12.462+03	2017-07-21 15:52:12.462+03	37	\N
78	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	6	14	1186	122	8824	2017-07-21 15:52:12.463+03	2017-07-21 15:52:12.463+03	36	\N
77	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	1	12	1390	7	1474	2017-07-21 15:52:12.463+03	2017-07-21 15:52:12.463+03	36	\N
86	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	1	119	730	153	\N	2017-07-21 15:57:02.995+03	2017-07-21 15:57:03.015+03	34	\N
66	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	2	92	1393	188	20082	2017-07-21 15:52:12.425+03	2017-09-21 22:23:15.64+03	\N	\N
90	2017-09-14	\N	\N	\N	1	\N	200	200	2017-09-14 16:05:57.837+03	2017-09-14 16:05:57.837+03	52	0
91	2017-09-14	\N	\N	\N	2	\N	300	600	2017-09-14 21:37:04.872+03	2017-09-14 21:37:04.872+03	53	0
93	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	\N	2017-09-19 23:39:30.354+03	2017-09-20 00:24:02.196+03	\N	0
99	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	0	83	1928	171	\N	2017-09-21 22:23:15.649+03	2017-09-21 22:23:15.686+03	30	0
100	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	1	99	1463	137	\N	2017-09-21 22:23:15.649+03	2017-09-21 22:23:15.686+03	30	0
101	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	46	316	161	\N	2017-09-21 22:23:15.649+03	2017-09-21 22:23:15.686+03	30	0
102	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	6	62	628	113	\N	2017-09-21 22:23:15.649+03	2017-09-21 22:23:15.686+03	30	0
103	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	2	92	1393	188	\N	2017-09-21 22:23:15.649+03	2017-09-21 22:23:15.686+03	30	0
92	2017-09-14	\N	\N	\N	2	\N	300	600	2017-09-14 21:37:04.872+03	2017-09-14 21:45:48.448+03	54	0
94	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	\N	2017-09-20 00:24:02.202+03	2017-09-20 00:24:02.212+03	14	0
95	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	19594	2017-09-20 00:24:02.202+03	2017-09-20 00:24:06.74+03	55	0
97	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	\N	2017-09-20 00:25:03.727+03	2017-09-20 00:25:39.897+03	\N	0
96	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	19594	2017-09-20 00:24:02.202+03	2017-09-20 00:25:03.722+03	\N	0
98	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	71	1448	174	\N	2017-09-20 00:25:39.899+03	2017-09-20 00:25:39.903+03	56	0
1	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	5	142	1049	148	26261	2017-07-21 15:52:12.227+03	2017-07-21 15:52:12.227+03	10	\N
7	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	4	10	737	108	4028	2017-07-21 15:52:12.228+03	2017-07-21 15:52:12.228+03	12	\N
11	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	5	51	463	63	5528	2017-07-21 15:52:12.283+03	2017-07-21 15:52:12.283+03	15	\N
16	2017-07-19	Good Guy vs. Bad Guys	Scoping Regular	3	131	1213	81	14250	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	16	\N
21	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	2	181	339	67	12805	2017-07-21 15:52:12.285+03	2017-07-21 15:52:12.285+03	17	\N
26	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	1	89	1031	38	4413	2017-07-21 15:52:12.348+03	2017-07-21 15:52:12.348+03	18	\N
31	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	3	36	47	154	5685	2017-07-21 15:52:12.349+03	2017-07-21 15:52:12.349+03	20	\N
36	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	1	27	381	139	4134	2017-07-21 15:52:12.35+03	2017-07-21 15:52:12.35+03	21	\N
42	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	3	5	325	40	1175	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	23	\N
47	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	1	102	603	23	2949	2017-07-21 15:52:12.392+03	2017-07-21 15:52:12.392+03	26	\N
52	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	4	168	399	15	4116	2017-07-21 15:52:12.393+03	2017-07-21 15:52:12.393+03	25	\N
57	2017-07-19	Good Guy vs. Bad Guys	Proofreading Rush	5	165	206	180	30730	2017-07-21 15:52:12.424+03	2017-07-21 15:52:12.424+03	32	\N
62	2017-07-20	Good Guy vs. Bad Guys	Scoping Regular	3	62	401	115	8333	2017-07-21 15:52:12.425+03	2017-07-21 15:52:12.425+03	31	\N
72	2017-07-18	Good Guy vs. Bad Guys	Scoping Regular	3	147	158	199	29727	2017-07-21 15:52:12.462+03	2017-07-21 15:52:12.462+03	33	\N
82	2017-07-21	Good Guy vs. Bad Guys	Scoping Regular	4	141	1505	198	33938	2017-07-21 15:52:12.463+03	2017-07-21 15:57:02.982+03	\N	\N
69	2017-07-18	Good Guy vs. Bad Guys	Proofreading Rush	0	32	1068	132	4224	2017-07-21 15:52:12.426+03	2017-07-21 15:52:12.426+03	29	\N
81	2017-07-21	Good Guy vs. Bad Guys	Proofreading Rush	1	119	730	153	18937	2017-07-21 15:52:12.463+03	2017-07-21 15:57:02.982+03	\N	\N
87	2017-07-30	\N	\N	\N	33	0	333	10989	2017-07-30 18:14:36.223+03	2017-08-01 01:51:15.02+03	\N	\N
\.


--
-- Name: InvoiceItems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"InvoiceItems_id_seq"', 103, true);


--
-- Data for Name: InvoiceTemplateProofreadingAndScopings; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "InvoiceTemplateProofreadingAndScopings" (id, "showInvoiceNumber", "showInvoiceDate", "showSignature", "showType", "showHourCount", "showHourRate", "showPageCount", "showPageRate", "showAdditionalTerms", "showDescription", "showNotes", "showReceipientName", "showReceipientSuffix", "showReceipientAddress", "showReceipientPhone", "showReceipientFax", "showReceipientEmail", "showReceipientRSProfile", "showSenderName", "showSenderSuffix", "showSenderAddress", "showSenderPhone", "showSenderFax", "showSenderEmail", "showSenderRSProfile", "showTrial", "createdAt", "updatedAt", "userId") FROM stdin;
1	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-21 15:52:11.528+03	2017-07-21 15:52:11.528+03	1
2	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-21 15:52:11.534+03	2017-07-21 15:52:11.534+03	2
3	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-25 17:23:19.383+03	2017-07-25 17:23:19.383+03	3
4	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-25 17:24:11.413+03	2017-07-25 17:24:11.413+03	4
5	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-09-14 15:23:16.252+03	2017-09-14 15:23:16.252+03	7
6	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-09-14 21:35:00.171+03	2017-09-14 21:35:00.171+03	8
\.


--
-- Name: InvoiceTemplateProofreadingAndScopings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"InvoiceTemplateProofreadingAndScopings_id_seq"', 6, true);


--
-- Data for Name: InvoiceTemplateStateAndFreelances; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "InvoiceTemplateStateAndFreelances" (id, "showInvoiceNumber", "showInvoiceDate", "showSignature", "showPageCount", "showPageRate", "showPageType", "showTranscribersCSROrId", "showBillableLineItemCode", "showReceipientName", "showReceipientSuffix", "showReceipientFirmName", "showReceipientAddress", "showReceipientPhone", "showReceipientFax", "showReceipientEmail", "showReceipientAssistantsName", "showReceipientAssistantsPhone", "showReceipientAssistantsFax", "showReceipientAssistantsEmail", "showReporterName", "showReporterSuffix", "showReporterAddress", "showReporterPhone", "showReporterFax", "showReporterEmail", "showReporterRSProfile", "showCourthouse", "showProceedingType", "showProceedingDate", "showCaseNumber", "showCaseCaption", "showTranscriptRequestedBy", "showJudgeHearingCase", "showTranscriptOrderedOn", "showTranscriptDeliveredOn", "showAdditionalTerms", "showDescription", "showNotes", "createdAt", "updatedAt", "userId", "showApprovedBy") FROM stdin;
1	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-21 15:52:11.507+03	2017-07-21 15:52:11.507+03	1	f
3	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-25 17:23:19.353+03	2017-07-25 17:23:19.353+03	3	f
4	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-25 17:24:11.397+03	2017-07-25 17:24:11.397+03	4	f
2	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-07-21 15:52:11.518+03	2017-07-21 15:52:11.518+03	2	f
5	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-09-14 15:23:16.235+03	2017-09-14 15:23:16.235+03	7	f
6	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	t	2017-09-14 21:35:00.148+03	2017-09-14 21:35:00.148+03	8	f
\.


--
-- Name: InvoiceTemplateStateAndFreelances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"InvoiceTemplateStateAndFreelances_id_seq"', 6, true);


--
-- Data for Name: Invoices; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "Invoices" (id, "sharedLinkToken", "invoiceNumber", "canBePaidWithStripe", "stripeFeePaidBySender", "stripeChargeData", date, "transcriptOrderedOn", "transcriptDeliveredOn", type, "recipientType", "caseType", "realtimeProvided", "caseNumber", plaintiff, defendant, description, notes, "proceedingsDate", "judgeHearingCase", courthouse, "transcriptOrderedBy", "dcnClassification", "appealCaNumber", "accountingType", "customerFirmName", "customerFirstName", "customerLastName", "customerMiddleName", "customerSuffix", "customerAddress", "customerAddressCont", "customerCity", "customerState", "customerZip", "customerPhone", "customerEmail", "customerFax", "customerAssistantName", "customerAssistantEmail", "customerAssistantPhone", "customerAssistantFax", "ratesOrdinaryOriginal", "ratesOrdinary1stCopy", "ratesOrdinary2ndCopy", "rates14DayOriginal", "rates14Day1stCopy", "rates14Day2ndCopy", "ratesExpeditedOriginal", "ratesExpedited1stCopy", "ratesExpedited2ndCopy", "ratesDailyOriginal", "ratesDaily1stCopy", "ratesDaily2ndCopy", "ratesHourlyOriginal", "ratesHourly1stCopy", "ratesHourly2ndCopy", "ratesRealtimeOriginal", "ratesRealtime1stCopy", "ratesRealtime2ndCopy", "pagesOrdinaryOriginal", "pagesOrdinary1stCopy", "pagesOrdinary2ndCopy", "pages14DayOriginal", "pages14Day1stCopy", "pages14Day2ndCopy", "pagesExpeditedOriginal", "pagesExpedited1stCopy", "pagesExpedited2ndCopy", "pagesDailyOriginal", "pagesDaily1stCopy", "pagesDaily2ndCopy", "pagesHourlyOriginal", "pagesHourly1stCopy", "pagesHourly2ndCopy", "pagesRealtimeOriginal", "pagesRealtime1stCopy", "pagesRealtime2ndCopy", "lateDiscount", total, "totalDue", "depositCheckDate", "refundCheckDate", "paidCheckDate", "depositCheckNumber", "refundCheckNumber", "paidCheckNumber", "depositAmount", "refundAmount", "paidAmount", "createdAt", "updatedAt", "userId", "customerId", "customerFirmId", "customerPrefix", "customerFirmContactFirstName", "customerFirmContactLastName", "customerFirmEmail", "customerFirmPhone", "customerFirmFax", "customerFirmAddress", "customerFirmAddressCont", "customerFirmState", "customerFirmCity", "customerFirmZip", "postageAmount", re, "taxRate", "caseTitle") FROM stdin;
11	11-a2f907c4-8c34-423c-8d06-f970943033a5	INV-774306	t	f	\N	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1584	1584	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.102+03	2017-07-21 15:52:12.482+03	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
10	10-ff6b32df-48a7-41d6-b7e5-f96ece3d33bd	INV-152369	t	f	\N	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	82875	82875	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.101+03	2017-07-21 15:52:12.484+03	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
13	13-f065e33a-c8cf-4720-9e50-a232e23695cf	INV-434193	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	14028	14028	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.104+03	2017-07-21 15:52:12.495+03	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
2	2-ebab0fca-2f63-4ee6-b331-ffb0f9d44f4f	INV-954148	t	f	\N	2017-07-20	2014-01-20	2014-01-20	it-federal	irt-official	ict-criminal	irp-us-attorney	481484	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-appeal	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	286	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21	0	0	0	12	0	0	0	6	0	0	0	0	0	0	20	8	0	10	6006	5996	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12+03	2017-07-21 15:52:12.048+03	1	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
5	5-265e7b35-5be5-4d5c-9542-b8069b010b6b	INV-935197	t	f	\N	2017-07-21	2014-01-20	2014-01-20	it-federal	irt-official	ict-criminal	irp-us-attorney	805411	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-na	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	287	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	8	0	0	0	11	0	0	0	9	0	0	0	0	0	0	17	7	0	10	2296	2286	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12+03	2017-07-21 15:52:12.049+03	1	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
4	4-056c08cc-3c9b-46a6-ba42-3a4d1085b8e9	INV-747322	t	f	\N	2017-07-19	2014-01-20	2014-01-20	it-federal	irt-official	ict-civil	irp-none	219481	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-judicial-officer-no-charge	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	227	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18	0	0	0	15	0	0	0	10	0	0	0	0	0	0	0	0	0	10	4086	4076	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12+03	2017-07-21 15:52:12.05+03	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
3	3-ff837d37-b683-4024-b27b-bbf0bcf8c4f6	INV-328905	t	f	\N	2017-07-20	2014-01-20	2014-01-20	it-federal	irt-official	ict-civil	irp-pub-defender	432472	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-na	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	236	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12	0	0	0	10	0	0	0	8	0	0	0	0	0	0	18	10	0	10	2832	2822	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12+03	2017-07-21 15:52:12.05+03	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
15	15-2623d888-f542-450a-a9c0-7ef95ef70cce	INV-256487	t	f	\N	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	37748	37748	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.105+03	2017-07-21 15:52:12.508+03	1	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
20	20-4a62a094-2114-4be8-9d5d-1621fe995046	INV-480857	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	75711	75711	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.175+03	2017-07-21 15:52:12.539+03	2	21	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
25	25-05b392a9-1a53-4da3-abc3-3b785da54dd7	INV-660084	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	30019	30019	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.18+03	2017-07-21 15:52:12.57+03	2	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
32	32-014cb951-a598-44a6-bc64-42105f1a8f3c	INV-141966	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	37906	37906	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.186+03	2017-07-21 15:52:12.578+03	2	29	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
21	21-1cde830d-9984-42f8-9334-0228add006a0	INV-98952	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	88316	88316	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.176+03	2017-07-21 15:52:12.544+03	2	21	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
16	16-3e317d37-a87e-4979-8356-3869eb1408d2	INV-641456	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	102798	102798	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.107+03	2017-07-21 15:52:12.515+03	1	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
35	35-228d8348-1758-4a8e-ba1d-d0fa1e12f860	INV-168873	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10714	10714	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.191+03	2017-07-21 15:52:12.617+03	2	30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
34	34-280350d7-4094-4bcf-a263-eaff82169b0f	INV-752356	t	f	\N	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	address	addressCont	New York	New York	12345	8765	reporter@test.com	8765	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	68818	0	\N	\N	2017-09-21	\N	\N	\N	200	0	68618	2017-07-21 15:52:12.189+03	2017-09-21 21:57:24.058+03	2	30	30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
26	26-b0ce859c-4cb0-4a32-b001-f5733a0fb221	INV-863880	t	f	\N	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12946	0	\N	\N	2017-09-21	\N	\N	\N	0	0	12946	2017-07-21 15:52:12.181+03	2017-09-21 22:28:31.109+03	2	27	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
30	30-3833aa6b-08c8-47e3-a5d5-85c23fc5312a	INV-990034	t	f	\N	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	69061	1	\N	\N	2017-09-21	\N	\N	\N	0	0	69060	2017-07-21 15:52:12.185+03	2017-09-21 22:23:15.691+03	2	29	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
24	24-ec351b85-f1c8-44ce-b0ce-01ee1f1c1d11	INV-552121	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	6150	6150	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.179+03	2017-07-21 15:52:12.55+03	2	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
19	19-e6ef1730-1946-497f-8533-b7f90a3d489a	INV-633092	t	f	\N	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	23384	23384	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.174+03	2017-07-21 15:52:12.544+03	2	21	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
44	44-cda45ad9-7252-40b1-9d6e-dceb0fda0e80	2017-05	t	f	\N	2017-05-03	2017-03-31	2017-05-09	it-federal	irt-official	ict-civil	\N	4:16-cv-700	Christopher Jones	Mike Carol	\N	\N	\N	\N	\N	\N	\N	\N	\N	National Center for Law and Economic Justice	Petra	Jones	\N	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	90	60	605	120	90	0	0	0	0	0	0	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	55480	55480	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-28 00:14:41.675+03	2017-07-28 00:15:10.874+03	4	56	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
8	8-e8e054fc-cb23-47a1-90ac-9be6f63845b2	INV-447733	t	f	\N	2017-07-20	2014-01-20	2014-01-20	it-federal	irt-official	ict-criminal	irp-us-attorney	208914	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-judicial-officer-no-charge	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	178	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	11	0	0	0	7	0	0	0	7	0	0	0	0	0	0	19	10	0	10	1958	1948	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.025+03	2017-07-21 15:52:12.077+03	2	25	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
40	40-76bf9040-5d8c-477d-990a-dffdabbdbcde	2017-09	t	f	\N	2017-07-25	2017-06-26	2017-07-25	it-federal	irt-official	ict-civil	\N	5:16-cv-89	Jeremy Burk	Patricia Smith	Telephone Hearing	\N	\N	\N	\N	\N	\N	\N	\N	Marie Mattox, P.A.	Marie	Mattox	\N	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	90	60	605	120	90	0	0	0	0	0	0	\N	\N	\N	25	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	10625	0	\N	\N	2017-07-27	\N	\N	\N	0	0	10625	2017-07-27 21:01:42.509+03	2017-07-27 23:58:08.859+03	4	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
41	41-1a02fbf1-ea30-479d-89b5-937f8e304db6	2017-08	t	f	{"id": "ch_1Am2iDHnNiTdLjj9K004TRlz", "paid": true, "order": null, "amount": 132495, "object": "charge", "review": null, "source": {"id": "card_1Am2iDHnNiTdLjj9xFSTWw4y", "name": null, "brand": "Visa", "last4": "0077", "object": "card", "country": "US", "funding": "credit", "customer": null, "exp_year": 2034, "metadata": {}, "cvc_check": "pass", "exp_month": 1, "address_zip": "34234", "fingerprint": "Yea1Uj3GTUtrmYR2", "address_city": null, "address_line1": null, "address_line2": null, "address_state": null, "dynamic_last4": null, "address_country": null, "address_zip_check": "pass", "address_line1_check": null, "tokenization_method": null}, "status": "succeeded", "created": 1501602913, "dispute": null, "invoice": null, "outcome": {"type": "authorized", "reason": null, "risk_level": "normal", "network_status": "approved_by_network", "seller_message": "Payment complete."}, "refunds": {"url": "/v1/charges/ch_1Am2iDHnNiTdLjj9K004TRlz/refunds", "data": [], "object": "list", "has_more": false, "total_count": 0}, "captured": true, "currency": "usd", "customer": null, "livemode": false, "metadata": {}, "refunded": false, "shipping": null, "application": "ca_Anagxe2oa9e2LdYn3uSL3E410edFQZHB", "description": "Payment for invoice 07/19/2017 - no. 2017-08", "destination": null, "failure_code": null, "on_behalf_of": null, "fraud_details": {}, "receipt_email": null, "receipt_number": null, "transfer_group": null, "amount_refunded": 0, "application_fee": "fee_1Am2iDHnNiTdLjj9PmfxNwau", "failure_message": null, "source_transfer": null, "balance_transaction": "txn_1Am2iDHnNiTdLjj9H4ikMzGh", "statement_descriptor": null}	2017-07-19	2017-06-19	2017-07-19	it-federal	irt-official	ict-civil	\N	4:15-cv-23	Snead	FAMU	Trial held 10-19-16 and 10-20-16	\N	2017-05-16	\N	Tallahassee	Mr. Johnson	\N	\N	iat-appeal	Richard E. Johnson, P.A.	Richard	Johnson	E.	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	90	60	605	120	90	0	0	0	0	0	0	363	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	132495	0	\N	\N	2017-08-01	\N	\N	\N	0	0	132495	2017-07-27 23:55:06.076+03	2017-08-01 18:55:14.585+03	4	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
28	28-077b7cd3-4da6-46ef-9989-b572589371c0	INV-426032	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	40273	40273	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.183+03	2017-07-21 15:52:12.569+03	2	27	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
23	23-87aae89e-d0c0-4ba0-87aa-be6110f468ba	INV-191432	t	f	\N	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	21640	21640	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.179+03	2017-07-21 15:52:12.553+03	2	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
29	29-c2d50cf6-dfae-4f26-9b08-97c499bb9517	INV-105640	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	24261	24261	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.184+03	2017-07-21 15:52:12.61+03	2	27	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
1	1-8a1c1740-811c-4c3c-8b83-a35efd524df1	INV-876237	t	f	\N	2017-07-21	2014-01-20	2014-01-20	it-federal	irt-official	ict-civil	irp-us-attorney	442180	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-appeal	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	280	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	9	0	0	0	12	0	0	0	9	0	0	0	0	0	0	18	7	0	10	2520	2510	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12+03	2017-07-21 15:52:12.05+03	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
42	42-c9214d68-65d9-4a1e-a2c8-f2b2ddd6b3ed	2017-07	t	f	\N	2017-06-13	2017-06-06	2017-06-13	it-federal	irt-official	ict-criminal	\N	4:15-cr-44	United States	Joseph Jones	Hearing held 6/6/17	\N	2017-06-06	\N	\N	\N	\N	\N	\N	Sanders and Duncan, P.A.	Barbara	Sanders	\N	Attorney at Law	Post Office Box 157	\N	Apalachicola	Florida	32329	(850) 653-5566	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	485	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18	0	0	0	0	0	0	0	0	0	0	0	0	8730	0	\N	\N	2017-07-27	\N	\N	\N	0	0	8730	2017-07-28 00:03:06.194+03	2017-07-28 00:03:19.478+03	4	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
48	48-1061ab21-154d-4b85-8c72-7d45dc8a2065	2017-01	t	f	\N	2017-02-05	2017-02-10	2017-02-05	it-federal	irt-official	ict-criminal	\N	4:17-cr-34	United States	Paul Christensen	\N	\N	2017-02-10	\N	\N	\N	\N	\N	\N	Federal Public Defender's Office	Michelle	Smith	J	Attorney at Law	101 Bronough Street	\N	Tallahassee	Florida	32301	850-123-456	michelle.smith@pd.gov	\N	\N	\N	\N	\N	365	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	786	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	286890	0	\N	\N	2017-02-10	\N	\N	\N	0	0	286890	2017-07-28 00:30:51.26+03	2017-07-28 00:31:08.718+03	4	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
12	12-82d30bd1-2613-49cf-9207-62f3047ba052	INV-441902	t	f	\N	2017-07-19	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12419	12419	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.103+03	2017-07-21 15:52:12.495+03	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
37	37-fd3560ef-6659-40dd-ad66-1e5f41e28c73	INV-166915	t	f	\N	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12024	12024	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.19+03	2017-07-21 15:52:12.617+03	2	30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
7	7-ee62a06a-52e6-45b0-8a3a-2792c6ad4a9f	INV-399883	t	f	\N	2017-07-19	2014-01-20	2014-01-20	it-federal	irt-official	ict-civil	irp-non-governmental-party	952446	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-na	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	283	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	24	0	0	0	7	0	0	0	8	0	0	0	0	0	0	16	10	0	10	6792	6782	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.025+03	2017-07-21 15:52:12.077+03	2	25	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
46	46-666dba73-5790-4922-bdee-8507161ef8e7	2017-03	t	f	\N	2017-04-19	2017-04-18	2017-04-26	it-federal	irt-official	ict-civil	\N	4:15-cv-100	United States	Greg Carter	\N	\N	2017-04-17	\N	\N	\N	\N	\N	\N	Sanders and Duncan, P.A.	Barbara	Sanders	\N	Attorney at Law	123 Main Street	\N	Apalachicola	Florida	32327	\N	\N	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	90	60	605	120	90	0	0	0	0	0	0	0	134	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	12060	0	\N	\N	2017-05-30	\N	\N	\N	0	0	12060	2017-07-28 00:25:56.872+03	2017-07-28 00:26:29.176+03	4	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
39	39-7aca77bb-9a29-4a81-ac5e-274cc89f7a26	2017-10	t	f	\N	2017-07-27	2017-07-20	2017-07-27	it-federal	irt-official	ict-criminal	\N	4:15-cr-10	United States	John Smith	Sentencing Proceedings	\N	2017-07-04	\N	Tallahassee	Mr. Simpson	\N	\N	\N	Federal Public Defender's Office	Michelle	Smith	J	Attorney at Law	\N	\N	\N	\N	\N	850-123-456	michelle.smith@pd.gov	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-27 20:47:30.309+03	2017-07-28 20:32:59.829+03	4	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
33	33-14b9b653-0f1a-4a45-8415-64d367b8ff03	INV-822317	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	35030	35030	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.187+03	2017-07-21 15:52:12.607+03	2	29	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
27	27-53e233dd-a370-425e-94d4-c3648410a4be	INV-990909	t	f	\N	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	18600	18600	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.182+03	2017-07-21 15:52:12.564+03	2	27	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
9	9-0d8079d5-f705-4c7d-9e8a-9f39fa18389b	INV-236449	t	f	\N	2017-07-21	2014-01-20	2014-01-20	it-federal	irt-official	ict-criminal	irp-non-governmental-party	527171	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-na	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	178	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	16	0	0	0	13	0	0	0	6	0	0	0	0	0	0	19	8	0	10	2848	2838	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.025+03	2017-07-21 15:52:12.077+03	2	25	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
45	45-b7a83387-c4a2-445e-8994-0d39d6f10fb4	2017-04	t	f	\N	2017-04-26	2017-03-30	2017-04-26	it-federal	irt-official	ict-criminal	\N	4:10-cr-70	United States	Paul Adams	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Jesse	Jones	\N	\N	1001 Sixth Avenue	\N	Tampa	Florida	33612	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	485	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	31	0	0	0	0	0	0	0	0	0	0	0	0	15035	0	\N	\N	2017-07-27	\N	\N	\N	0	0	15035	2017-07-28 00:18:14.725+03	2017-07-28 00:18:25.883+03	4	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
51	51-3ca7d485-d694-405c-aeb3-79d2bdf5102a	abc	t	f	\N	2017-07-31	\N	\N	it-federal	irt-official	ict-civil	\N	\N	\N	\N	\N	Additional Information\n\nFull price may be charged only if the transcript is delivered within the required time frame. For example, if an order for expedited transcript is not completed and delivered within (7) calendar days, payment would be at the 14-day delivery rate, and if not completed and delivered within 14 days, payment would be at the ordinary delivery rate.\nI certify that the transcript fees charged and page format used comply with the requirements of this court and the Judicial Conference of the United States.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	90	60	605	120	90	725	120	90	305	150	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-31 16:05:13.383+03	2017-08-01 18:54:21.397+03	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
17	17-3d89952e-b8e1-4426-b446-117410e0a8fe	INV-659897	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	23313	23313	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.11+03	2017-07-21 15:52:12.525+03	1	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
36	36-9e36c18a-c82d-4fd6-8459-8b34d757252c	INV-397031	t	f	\N	2017-07-18	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	31642	31642	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12.192+03	2017-07-21 15:52:12.622+03	2	30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
50	50-bb43b647-fd3e-4502-ab93-183a62226d30	20170010	t	f	\N	2017-07-30	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Judy A.	Gagnon	\N	\N	111 North Adams Street	\N	Tallahassee	Florida	32301	(850) 561-6822	judy.gagnon@reportersuite.com	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	10989	10989	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-30 18:14:36.204+03	2017-08-01 01:52:43.148+03	4	59	59	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
6	6-1dc4d2c9-1a5f-4ae6-8185-1233db9942f8	INV-165337	t	f	\N	2017-07-19	2014-01-20	2014-01-20	it-federal	irt-official	ict-civil	irp-pub-defender	593967	Mr. Good Guy	Mr. Bad Guy	description	\N	\N	\N	\N	\N	\N	\N	iat-judicial-officer-no-charge	\N	First Name	Last Name	\N	Suffix	Example street 2	App. 44	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	assistantName	assistant@test.com	+12345	\N	115	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	17	0	0	0	6	0	0	0	6	0	0	0	0	0	0	18	9	0	10	1955	1945	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-21 15:52:12+03	2017-07-21 15:52:12.076+03	1	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
43	43-28a81eb0-1a4c-42c9-a1e0-c8ce86e73a6a	2017-06	t	f	\N	2017-05-04	2017-04-04	2017-05-04	it-federal	irt-official	ict-criminal	\N	4:15-cr-21	United States	Craig Hath	\N	\N	2015-09-15	\N	\N	\N	\N	\N	\N	Chipola Law	Barbara	Throne	Jean	Attorney at Law	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	365	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	10950	10950	\N	\N	\N	\N	\N	\N	0	0	0	2017-07-28 00:09:45.293+03	2017-07-28 00:10:01.385+03	4	54	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
47	47-65ad6a2e-ee1f-46ca-9b61-212124740c31	2017-02	t	f	\N	2017-03-02	2017-02-24	2017-03-02	it-federal	irt-official	ict-civil	\N	4:16-cv-34	James Honeywell	Patricia Cook	\N	\N	2017-02-24	\N	\N	\N	\N	\N	\N	Marie Mattox, P.A.	Marie	Mattox	\N	Attorney at Law	321 Bradford Road	\N	Tallahassee	Florida	32301	\N	\N	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	90	60	605	120	90	0	0	0	0	0	0	1234	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	450410	0	\N	\N	2017-03-27	\N	\N	\N	0	0	450410	2017-07-28 00:28:40.528+03	2017-07-28 00:28:57.975+03	4	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
52	52-ebd257c0-6e00-45cc-b7ed-b4f624d27429	201700001	t	f	\N	2017-09-14	\N	\N	it-state-and-freelance	\N	ict-criminal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	200	200	\N	\N	\N	\N	\N	\N	0	0	0	2017-09-14 16:05:57.774+03	2017-09-14 16:05:57.851+03	7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
53	53-fc23b717-ebdb-4f77-9ea5-8aa545652748	201700001	t	f	\N	2017-09-14	\N	\N	it-state-and-freelance	\N	ict-criminal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	600	600	\N	\N	\N	\N	\N	\N	0	0	0	2017-09-14 21:37:04.838+03	2017-09-14 21:37:04.887+03	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
54	54-5ca7950e-f3c3-4fb7-bed6-e2db2cc925f4	201700002	t	f	\N	2017-09-14	\N	\N	it-state-and-freelance	\N	ict-criminal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	\N	600	600	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-14 21:45:48.431+03	2017-09-14 21:45:48.461+03	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	14-b227724b-82fe-4f51-8b30-1d961259e619	=;dsf===dsf;;'dsaz'"sdf  \\	t	f	\N	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	19594	0	2017-08-30	\N	2017-09-19	\N	\N	sdfdf	0	0	19594	2017-07-21 15:52:12.104+03	2017-09-20 00:24:02.217+03	1	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
55	55-9713cf7a-8280-43bd-a89c-16813379627d	INV-954149	t	f	\N	2017-09-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	\N	19594	0	2017-08-30	\N	2017-09-19	\N	\N	sdfdf	\N	\N	19594	2017-09-20 00:24:06.717+03	2017-09-20 00:24:06.747+03	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N
56	56-205eb201-b2c0-47a0-b913-ba5493b4e93d	INV-954150	t	f	\N	2017-09-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	20182	20182	\N	\N	\N	\N	\N	\N	0	0	0	2017-09-20 00:25:00.86+03	2017-09-20 00:25:39.905+03	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	30000	\N
57	57-b7116ff8-8134-4bdb-9b8b-502e2bc35f52	INV-990910	t	f	\N	2017-09-21	\N	\N	it-federal	irt-official	ict-criminal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	\N	\N	\N	\N	\N	\N	0	0	0	2017-09-21 19:50:37.848+03	2017-09-21 19:50:37.867+03	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
38	38-13975e81-dca0-4afc-8183-b71c872a9563	20171	t	f	{"id": "ch_1B4Z4yIYX5GAvZPwdKIO4AA7", "paid": true, "order": null, "amount": 3650, "object": "charge", "review": null, "source": {"id": "card_1B4Z4yIYX5GAvZPw2RV5RJDI", "name": null, "brand": "Visa", "last4": "0077", "object": "card", "country": "US", "funding": "credit", "customer": null, "exp_year": 2021, "metadata": {}, "cvc_check": "pass", "exp_month": 11, "address_zip": "12121", "fingerprint": "z1RcmUNfqSIMjo2Y", "address_city": null, "address_line1": null, "address_line2": null, "address_state": null, "dynamic_last4": null, "address_country": null, "address_zip_check": "pass", "address_line1_check": null, "tokenization_method": null}, "status": "succeeded", "created": 1506017236, "dispute": null, "invoice": null, "outcome": {"type": "authorized", "reason": null, "risk_level": "normal", "network_status": "approved_by_network", "seller_message": "Payment complete."}, "refunds": {"url": "/v1/charges/ch_1B4Z4yIYX5GAvZPwdKIO4AA7/refunds", "data": [], "object": "list", "has_more": false, "total_count": 0}, "captured": true, "currency": "usd", "customer": null, "livemode": false, "metadata": {}, "refunded": false, "shipping": null, "application": "ca_AXCJJcG0MdyurYKTlI4CbNz9YQFhl58l", "description": "Payment for invoice 07/23/2017 - no. 20171", "destination": null, "failure_code": null, "on_behalf_of": null, "fraud_details": {}, "receipt_email": null, "receipt_number": null, "transfer_group": null, "amount_refunded": 0, "application_fee": "fee_1B4Z4yIYX5GAvZPwgyUMkh1i", "failure_message": null, "source_transfer": null, "balance_transaction": "txn_1B4Z4yIYX5GAvZPww8W49fb7", "statement_descriptor": null}	2017-07-23	2017-07-23	2017-07-23	it-federal	irt-official	ict-civil	\N	4:15-cv-23	John Cook	Patrick Henry	Pretrial motion held 7/11/17	\N	2017-07-11	\N	\N	John Smith	USA 17	\N	iat-na	Smith & Jones	Paul	Johnson	M.	Attorney at Law	\N	\N	\N	\N	\N	(850)561-6822	pj@smith.com	\N	\N	\N	\N	\N	365	90	60	425	90	60	485	0	0	0	0	0	0	0	0	0	0	0	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	3650	0	\N	\N	2017-09-21	\N	\N	\N	0	0	3650	2017-07-23 20:04:44.09+03	2017-09-21 21:07:17.108+03	2	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
22	22-77180ae2-56c9-4a9c-ba36-dd81c511cbc6	INV-435045	t	f	{"id": "ch_1B4nJbIYX5GAvZPwSU2tuR2F", "paid": true, "order": null, "amount": 20493, "object": "charge", "review": null, "source": {"id": "card_1B4nJbIYX5GAvZPwsq2SXTtl", "name": null, "brand": "Visa", "last4": "0077", "object": "card", "country": "US", "funding": "credit", "customer": null, "exp_year": 2032, "metadata": {}, "cvc_check": "pass", "exp_month": 2, "address_zip": "23232", "fingerprint": "z1RcmUNfqSIMjo2Y", "address_city": null, "address_line1": null, "address_line2": null, "address_state": null, "dynamic_last4": null, "address_country": null, "address_zip_check": "pass", "address_line1_check": null, "tokenization_method": null}, "status": "succeeded", "created": 1506071959, "dispute": null, "invoice": null, "outcome": {"type": "authorized", "reason": null, "risk_level": "normal", "network_status": "approved_by_network", "seller_message": "Payment complete."}, "refunds": {"url": "/v1/charges/ch_1B4nJbIYX5GAvZPwSU2tuR2F/refunds", "data": [], "object": "list", "has_more": false, "total_count": 0}, "captured": true, "currency": "usd", "customer": null, "livemode": false, "metadata": {}, "refunded": false, "shipping": null, "application": "ca_AXCJJcG0MdyurYKTlI4CbNz9YQFhl58l", "description": "Payment for invoice 07/21/2017 - no. INV-435045", "destination": null, "failure_code": null, "on_behalf_of": null, "fraud_details": {}, "receipt_email": null, "receipt_number": null, "transfer_group": null, "amount_refunded": 0, "application_fee": "fee_1B4nJbIYX5GAvZPww4FjxR52", "failure_message": null, "source_transfer": null, "balance_transaction": "txn_1B4nJbIYX5GAvZPw5yuJeTaS", "statement_descriptor": null}	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	20493	0	\N	\N	2017-09-22	\N	\N	\N	0	0	20493	2017-07-21 15:52:12.177+03	2017-09-22 12:19:20.386+03	2	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
18	18-b3ace977-0361-4796-8fef-85758d7f3363	INV-524075	t	f	{"id": "ch_1B4nLCIYX5GAvZPwpOKAasvf", "paid": true, "order": null, "amount": 36302, "object": "charge", "review": null, "source": {"id": "card_1B4nLCIYX5GAvZPw5r7EV3pB", "name": null, "brand": "Visa", "last4": "0077", "object": "card", "country": "US", "funding": "credit", "customer": null, "exp_year": 2032, "metadata": {}, "cvc_check": "pass", "exp_month": 2, "address_zip": "23232", "fingerprint": "z1RcmUNfqSIMjo2Y", "address_city": null, "address_line1": null, "address_line2": null, "address_state": null, "dynamic_last4": null, "address_country": null, "address_zip_check": "pass", "address_line1_check": null, "tokenization_method": null}, "status": "succeeded", "created": 1506072058, "dispute": null, "invoice": null, "outcome": {"type": "authorized", "reason": null, "risk_level": "normal", "network_status": "approved_by_network", "seller_message": "Payment complete."}, "refunds": {"url": "/v1/charges/ch_1B4nLCIYX5GAvZPwpOKAasvf/refunds", "data": [], "object": "list", "has_more": false, "total_count": 0}, "captured": true, "currency": "usd", "customer": null, "livemode": false, "metadata": {}, "refunded": false, "shipping": null, "application": "ca_AXCJJcG0MdyurYKTlI4CbNz9YQFhl58l", "description": "Payment for invoice 07/21/2017 - no. INV-524075", "destination": null, "failure_code": null, "on_behalf_of": null, "fraud_details": {}, "receipt_email": null, "receipt_number": null, "transfer_group": null, "amount_refunded": 0, "application_fee": "fee_1B4nLCIYX5GAvZPwICpEbNW3", "failure_message": null, "source_transfer": null, "balance_transaction": "txn_1B4nLCIYX5GAvZPwyJp2LKl6", "statement_descriptor": null}	2017-07-21	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	36302	0	\N	\N	2017-09-22	\N	\N	\N	0	0	36302	2017-07-21 15:52:12.173+03	2017-09-22 12:20:59.649+03	2	21	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
31	31-7ee7fc33-951c-4491-889d-64ae3edebd13	INV-361503	t	f	{"id": "ch_1B4nMnIYX5GAvZPwZsKAyFIi", "paid": true, "order": null, "amount": 50343, "object": "charge", "review": null, "source": {"id": "card_1B4nMnIYX5GAvZPwLM5LxaC7", "name": null, "brand": "Visa", "last4": "0077", "object": "card", "country": "US", "funding": "credit", "customer": null, "exp_year": 2032, "metadata": {}, "cvc_check": "pass", "exp_month": 2, "address_zip": "32323", "fingerprint": "z1RcmUNfqSIMjo2Y", "address_city": null, "address_line1": null, "address_line2": null, "address_state": null, "dynamic_last4": null, "address_country": null, "address_zip_check": "pass", "address_line1_check": null, "tokenization_method": null}, "status": "succeeded", "created": 1506072157, "dispute": null, "invoice": null, "outcome": {"type": "authorized", "reason": null, "risk_level": "normal", "network_status": "approved_by_network", "seller_message": "Payment complete."}, "refunds": {"url": "/v1/charges/ch_1B4nMnIYX5GAvZPwZsKAyFIi/refunds", "data": [], "object": "list", "has_more": false, "total_count": 0}, "captured": true, "currency": "usd", "customer": null, "livemode": false, "metadata": {}, "refunded": false, "shipping": null, "application": "ca_AXCJJcG0MdyurYKTlI4CbNz9YQFhl58l", "description": "Payment for invoice 07/20/2017 - no. INV-361503", "destination": null, "failure_code": null, "on_behalf_of": null, "fraud_details": {}, "receipt_email": null, "receipt_number": null, "transfer_group": null, "amount_refunded": 0, "application_fee": "fee_1B4nMnIYX5GAvZPwvx5mUJ2P", "failure_message": null, "source_transfer": null, "balance_transaction": "txn_1B4nMnIYX5GAvZPwjsgfshXa", "statement_descriptor": null}	2017-07-20	\N	\N	it-proofreading-and-scoping	\N	\N	\N	\N	\N	\N	\N	Some notes	\N	\N	\N	\N	\N	\N	\N	\N	First Name	Last Name	\N	\N	Example Street	app. 42	New York	New York	32399	+1234567	foo@bar.com	abcadsfsfs	\N	\N	\N	\N	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	50343	0	\N	\N	2017-09-22	\N	\N	\N	0	0	50343	2017-07-21 15:52:12.186+03	2017-09-22 12:22:38.156+03	2	29	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N
\.


--
-- Name: Invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"Invoices_id_seq"', 57, true);


--
-- Data for Name: Notifications; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "Notifications" (id, "userId", "invoiceId", title, body, date, type, "createdAt", "updatedAt", "invoiceSharedLinkToken") FROM stdin;
1	2	18	\N	\N	2017-09-22 12:20:59.71+03	nt-invoice-payment-received	2017-09-22 12:20:59.711+03	2017-09-22 12:20:59.711+03	\N
2	2	31	\N	\N	2017-09-22 12:22:38.175+03	nt-invoice-payment-received	2017-09-22 12:22:38.175+03	2017-09-22 12:22:38.175+03	\N
\.


--
-- Name: Notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"Notifications_id_seq"', 2, true);


--
-- Data for Name: Payees; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "Payees" (id, name, "accountNumber", "contactName", phone, fax, email, website, address, "addressCont", city, state, zip, notes, "createdAt", "updatedAt", "userId") FROM stdin;
21	abc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-31 11:45:48.349+03	2017-07-31 11:45:48.349+03	4
28	afdfd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-20 15:21:05.266+03	2017-09-20 15:21:05.266+03	2
29	sdfsdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-20 15:48:51.759+03	2017-09-20 15:48:51.759+03	1
30	sdafsda	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-21 13:20:26.587+03	2017-09-21 19:51:14.94+03	2
31	sdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-21 20:01:14.122+03	2017-09-21 20:01:32.664+03	2
\.


--
-- Name: Payees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"Payees_id_seq"', 31, true);


--
-- Data for Name: SentEmails; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "SentEmails" (id, type, "dateSent", receipient, subject, "createdAt", "updatedAt", "invoiceId") FROM stdin;
1	et-invoice	2017-07-31 16:24:51.062+03	mike.ellan@reportersuite.com	Invoice - 435245 from Judy A. Gagnon null	2017-07-31 16:24:51.064+03	2017-07-31 16:24:51.078+03	50
2	et-invoice	2017-09-14 21:40:31.806+03	a@b.com	Invoice - 201700001 from sdf sdf null	2017-09-14 21:40:31.806+03	2017-09-14 21:40:31.814+03	53
3	et-invoice	2017-09-14 21:41:45.724+03	a@b.com	Invoice - 201700001 from sdf sdf null	2017-09-14 21:41:45.724+03	2017-09-14 21:41:45.73+03	53
4	et-invoice	2017-09-14 21:41:56.374+03	a@b.com	Invoice - 201700001 from sdf sdf null	2017-09-14 21:41:56.374+03	2017-09-14 21:41:56.379+03	53
5	et-invoice-payment-received	2017-09-22 12:20:59.721+03	user2@test.com	Payment received for invoice INV-524075	2017-09-22 12:20:59.721+03	2017-09-22 12:20:59.721+03	18
6	et-invoice-payment-received	2017-09-22 12:22:38.185+03	user2@test.com	Payment received for invoice INV-361503	2017-09-22 12:22:38.185+03	2017-09-22 12:22:38.185+03	31
\.


--
-- Name: SentEmails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"SentEmails_id_seq"', 6, true);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "SequelizeMeta" (name) FROM stdin;
20170803123914-initial.js
20170804063221-add-customer-firm-fields.js
20170804154202-create-notification.js
20170804163216-add-user-last-seen-notifiction-id.js
20170804170135-notification-add-invoice-shared-link-token.js
20170807091932-case-log-add-page-count.js
20170807123902-invoice-item-add-fee-field.js
20170807150222-add-user-state-and-freelance-page-rate-fields.js
20170809171044-user-add-is-admin-field.js
20170810062457-create-config-value.js
20170810124602-invoice-add-postage-amount.js
20170811134544-time-entry-add-case-number-and-case-name.js
20170811141033-time-entry-add-report-other-to-whom.js
20170811171531-time-entry-add-standard-page-count.js
20170815075945-invoice-add-re.js
20170815135534-user-add-tax-rate.js
20170815171153-invoice-add-tax.js
20170816113057-customer-add-rate-fields.js
20170822150345-invoice-state-add-case-title.js
20170823124946-user-add-billing-period-and-plan.js
20170825085733-state-and-freelance-invoice-add-approved-by.js
20170828155729-user-add-federal-invoice-title.js
20170922125810-user-add-notification-settings-fields.js
\.


--
-- Data for Name: TimeCategories; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "TimeCategories" (id, name, description, "isBuiltIn", "createdAt", "updatedAt", "userId") FROM stdin;
1	Leave	\N	t	2017-07-21 15:52:11.14+03	2017-07-21 15:52:11.14+03	\N
2	7d. - Official Proceedings	\N	t	2017-07-21 15:52:11.151+03	2017-07-21 15:52:11.151+03	\N
3	7e. - Substitute Reporter Proceedings	\N	t	2017-07-21 15:52:11.157+03	2017-07-21 15:52:11.157+03	\N
4	8a. - Reporting Administration	\N	t	2017-07-21 15:52:11.157+03	2017-07-21 15:52:11.157+03	\N
5	8b. - Other Duties as Assigned	\N	t	2017-07-21 15:52:11.158+03	2017-07-21 15:52:11.158+03	\N
6	9a. - Non-Salary Compensated Transcribing	\N	t	2017-07-21 15:52:11.205+03	2017-07-21 15:52:11.205+03	\N
7	9b. - Other Transcribing	\N	t	2017-07-21 15:52:11.21+03	2017-07-21 15:52:11.21+03	\N
8	10. - Travel	\N	t	2017-07-21 15:52:11.211+03	2017-07-21 15:52:11.211+03	\N
9	Lunch	\N	f	2017-07-30 18:17:02.558+03	2017-07-30 18:17:02.558+03	4
11	afd	dfdf	f	2017-09-21 13:14:50.651+03	2017-09-21 13:14:50.651+03	2
12	sdfdsf	\N	f	2017-09-21 13:15:34.677+03	2017-09-21 13:15:34.677+03	2
13	sd	sdf	f	2017-09-21 13:16:24.868+03	2017-09-21 13:16:24.868+03	2
14	sdf	\N	f	2017-09-21 13:17:33.318+03	2017-09-21 13:17:33.318+03	2
15	adfdf	\N	f	2017-09-21 13:18:26.06+03	2017-09-21 13:18:26.06+03	2
16	dsfdf	\N	f	2017-09-21 13:20:11.978+03	2017-09-21 13:20:11.978+03	2
17	df	\N	f	2017-09-21 19:35:38.839+03	2017-09-21 19:35:38.839+03	1
18	Krasnodar	\N	f	2017-09-21 19:35:48.482+03	2017-09-21 19:35:48.482+03	1
19	df	\N	f	2017-09-21 19:35:59.907+03	2017-09-21 19:35:59.907+03	1
20	dsfdsf	\N	f	2017-09-21 19:38:42.311+03	2017-09-21 19:38:42.311+03	1
21	xxx	\N	f	2017-09-21 19:39:23.154+03	2017-09-21 19:39:23.154+03	1
22	dsfdsf	\N	f	2017-09-21 19:39:27.694+03	2017-09-21 19:39:27.694+03	1
23	sdf	\N	f	2017-09-21 19:39:49.787+03	2017-09-21 19:39:49.787+03	1
24	sdffsad	\N	f	2017-09-21 19:39:52.633+03	2017-09-21 19:39:52.633+03	1
25	sdfsfd	\N	f	2017-09-21 19:40:43.649+03	2017-09-21 19:40:43.649+03	1
\.


--
-- Name: TimeCategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"TimeCategories_id_seq"', 25, true);


--
-- Data for Name: TimeEntries; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "TimeEntries" (id, city, date, "judgeInitials", "estimatedRealtimePageCount", "minutesTracked", notes, "substituteReporterName", "travelMilage", "leaveCategory", "proceedingsCategory", "createdAt", "updatedAt", "userId", "categoryId", "caseName", "caseNumber", "reportingOtherToWhom", "estimatedStandardPageCount") FROM stdin;
2	\N	2017-07-20	Goodenough J.	3	60	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
3	\N	2017-07-19	Goodenough J.	3	90	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
5	\N	2017-07-17	Goodenough J.	3	390	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
4	\N	2017-07-18	Goodenough J.	3	300	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
7	\N	2017-07-15	Goodenough J.	3	420	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
6	\N	2017-07-16	Goodenough J.	3	480	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
8	\N	2017-07-14	Goodenough J.	3	340	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
9	Chicago	2017-07-13	Goodenough J.	3	70	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
10	\N	2017-07-12	Goodenough J.	3	15	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
11	\N	2017-07-11	Goodenough J.	3	70	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
12	\N	2017-07-10	Goodenough J.	3	160	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
13	\N	2017-07-09	Goodenough J.	3	270	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
14	\N	2017-07-08	Goodenough J.	3	150	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
15	Chicago	2017-07-07	Goodenough J.	3	90	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
16	\N	2017-07-06	Goodenough J.	3	380	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
17	\N	2017-07-05	Goodenough J.	3	430	some notes	\N	\N	te-lc-without-pay	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
18	\N	2017-07-04	Goodenough J.	3	180	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
19	\N	2017-07-03	Goodenough J.	3	140	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
20	\N	2017-07-02	Goodenough J.	3	160	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
21	Boston	2017-07-01	Goodenough J.	3	460	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
22	\N	2017-06-30	Goodenough J.	3	100	some notes	\N	\N	te-lc-without-pay	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
23	\N	2017-06-29	Goodenough J.	3	320	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
24	\N	2017-06-28	Goodenough J.	3	220	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
25	\N	2017-06-27	Goodenough J.	3	170	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
26	\N	2017-06-26	Goodenough J.	3	210	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
27	\N	2017-06-25	Goodenough J.	3	190	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
28	\N	2017-06-24	Goodenough J.	3	140	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
29	\N	2017-06-23	Goodenough J.	3	120	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
30	\N	2017-06-22	Goodenough J.	3	220	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
32	\N	2017-06-20	Goodenough J.	3	130	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
31	Chicago	2017-06-21	Goodenough J.	3	330	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
33	Boston	2017-06-19	Goodenough J.	3	210	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
34	\N	2017-06-18	Goodenough J.	3	180	some notes	\N	\N	te-lc-without-other	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
35	\N	2017-06-17	Goodenough J.	3	80	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
37	\N	2017-06-15	Goodenough J.	3	480	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
36	Boston	2017-06-16	Goodenough J.	3	200	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
38	\N	2017-06-14	Goodenough J.	3	15	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
39	\N	2017-06-13	Goodenough J.	3	250	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
40	\N	2017-06-12	Goodenough J.	3	360	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
41	\N	2017-06-11	Goodenough J.	3	460	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
42	New York	2017-06-10	Goodenough J.	3	480	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
43	\N	2017-06-09	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
44	\N	2017-06-08	Goodenough J.	3	370	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
45	\N	2017-06-07	Goodenough J.	3	290	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
46	\N	2017-06-06	Goodenough J.	3	390	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
47	\N	2017-06-05	Goodenough J.	3	70	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
48	\N	2017-06-04	Goodenough J.	3	80	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
49	Chicago	2017-06-03	Goodenough J.	3	220	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
50	\N	2017-06-02	Goodenough J.	3	30	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
51	\N	2017-06-01	Goodenough J.	3	380	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
52	Chicago	2017-05-31	Goodenough J.	3	100	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
53	\N	2017-05-30	Goodenough J.	3	390	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
54	Chicago	2017-05-29	Goodenough J.	3	90	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
55	\N	2017-05-28	Goodenough J.	3	50	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
56	\N	2017-05-27	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
57	Chicago	2017-05-26	Goodenough J.	3	400	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
58	Chicago	2017-05-25	Goodenough J.	3	300	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
59	Chicago	2017-05-24	Goodenough J.	3	300	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
60	\N	2017-05-23	Goodenough J.	3	280	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
61	\N	2017-05-22	Goodenough J.	3	60	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
62	\N	2017-05-21	Goodenough J.	3	420	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
63	Boston	2017-05-20	Goodenough J.	3	380	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
64	\N	2017-05-19	Goodenough J.	3	100	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
65	New York	2017-05-18	Goodenough J.	3	400	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
66	\N	2017-05-17	Goodenough J.	3	200	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
67	\N	2017-05-16	Goodenough J.	3	50	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
68	New York	2017-05-15	Goodenough J.	3	70	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
69	\N	2017-05-14	Goodenough J.	3	40	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
70	\N	2017-05-13	Goodenough J.	3	350	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
71	\N	2017-05-12	Goodenough J.	3	290	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
72	\N	2017-05-11	Goodenough J.	3	220	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
73	\N	2017-05-10	Goodenough J.	3	140	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
74	New York	2017-05-09	Goodenough J.	3	320	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
75	\N	2017-05-08	Goodenough J.	3	270	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
80	\N	2017-05-03	Goodenough J.	3	160	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
85	\N	2017-04-28	Goodenough J.	3	290	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
89	Chicago	2017-04-24	Goodenough J.	3	330	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
94	\N	2017-04-19	Goodenough J.	3	250	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
100	Boston	2017-04-13	Goodenough J.	3	170	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	2	\N	\N	\N	\N
105	\N	2017-07-17	Goodenough J.	3	40	some notes	\N	\N	te-lc-without-other	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
110	\N	2017-07-12	Goodenough J.	3	130	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
115	New York	2017-07-07	Goodenough J.	3	300	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
120	\N	2017-07-02	Goodenough J.	3	90	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
124	\N	2017-06-28	Goodenough J.	3	80	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
129	\N	2017-06-23	Goodenough J.	3	180	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
134	\N	2017-06-18	Goodenough J.	3	250	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
139	\N	2017-06-13	Goodenough J.	3	60	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
144	\N	2017-06-08	Goodenough J.	3	410	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
149	Boston	2017-06-03	Goodenough J.	3	140	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
154	\N	2017-05-29	Goodenough J.	3	340	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
159	\N	2017-05-24	Goodenough J.	3	60	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
161	\N	2017-05-22	Goodenough J.	3	160	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
166	Boston	2017-05-17	Goodenough J.	3	30	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
171	\N	2017-05-12	Goodenough J.	3	330	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
176	\N	2017-05-07	Goodenough J.	3	400	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
181	Boston	2017-05-02	Goodenough J.	3	120	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
186	\N	2017-04-27	Goodenough J.	3	210	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
191	\N	2017-04-22	Goodenough J.	3	350	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
196	\N	2017-04-17	Goodenough J.	3	190	some notes	\N	\N	te-lc-without-other	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
201	\N	2017-07-23	\N	\N	60	\N	\N	\N	\N	\N	2017-07-23 18:01:31.378+03	2017-07-23 18:01:31.378+03	2	4	\N	\N	\N	\N
209	\N	2017-07-27	\N	\N	240	\N	\N	\N	\N	\N	2017-07-27 20:52:15.008+03	2017-07-27 20:52:15.008+03	4	8	\N	\N	\N	\N
211	\N	2017-07-24	\N	\N	240	\N	\N	\N	\N	\N	2017-07-27 20:56:29.739+03	2017-07-27 20:56:29.739+03	4	4	\N	\N	\N	\N
76	\N	2017-05-07	Goodenough J.	3	100	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
81	\N	2017-05-02	Goodenough J.	3	210	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
86	\N	2017-04-27	Goodenough J.	3	380	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
91	\N	2017-04-22	Goodenough J.	3	90	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
96	\N	2017-04-17	Goodenough J.	3	440	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
101	\N	2017-07-21	Goodenough J.	3	290	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
106	\N	2017-07-16	Goodenough J.	3	420	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
111	Boston	2017-07-11	Goodenough J.	3	360	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
116	Boston	2017-07-06	Goodenough J.	3	300	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
121	\N	2017-07-01	Goodenough J.	3	340	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
126	\N	2017-06-26	Goodenough J.	3	330	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
131	\N	2017-06-21	Goodenough J.	3	300	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
136	New York	2017-06-16	Goodenough J.	3	140	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
141	Chicago	2017-06-11	Goodenough J.	3	350	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
146	\N	2017-06-06	Goodenough J.	3	270	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
151	\N	2017-06-01	Goodenough J.	3	200	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
156	\N	2017-05-27	Goodenough J.	3	390	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
162	\N	2017-05-21	Goodenough J.	3	380	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
168	\N	2017-05-15	Goodenough J.	3	200	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
173	New York	2017-05-10	Goodenough J.	3	90	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
178	Chicago	2017-05-05	Goodenough J.	3	190	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
183	\N	2017-04-30	Goodenough J.	3	170	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
187	\N	2017-04-26	Goodenough J.	3	360	some notes	\N	\N	te-lc-comp	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
192	\N	2017-04-21	Goodenough J.	3	270	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
197	\N	2017-04-16	Goodenough J.	3	320	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
203	\N	2017-07-23	\N	\N	300	\N	\N	\N	\N	\N	2017-07-23 20:16:16.191+03	2017-07-23 20:16:16.191+03	2	6	\N	\N	\N	\N
206	Panama City	2017-07-27	MJE	\N	180	\N	\N	\N	\N	te-pc-judges	2017-07-27 19:25:08.673+03	2017-07-27 20:55:12.814+03	4	2	\N	\N	\N	\N
213	\N	2017-07-21	\N	\N	300	\N	\N	\N	\N	\N	2017-07-27 20:57:05.045+03	2017-07-27 20:57:05.045+03	4	6	\N	\N	\N	\N
77	\N	2017-05-06	Goodenough J.	3	190	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	5	\N	\N	\N	\N
82	\N	2017-05-01	Goodenough J.	3	250	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
87	\N	2017-04-26	Goodenough J.	3	310	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
93	\N	2017-04-20	Goodenough J.	3	440	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
98	\N	2017-04-15	Goodenough J.	3	80	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
103	\N	2017-07-19	Goodenough J.	3	15	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
108	\N	2017-07-14	Goodenough J.	3	340	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
113	\N	2017-07-09	Goodenough J.	3	160	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
118	\N	2017-07-04	Goodenough J.	3	90	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
123	\N	2017-06-29	Goodenough J.	3	240	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
128	New York	2017-06-24	Goodenough J.	3	160	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
133	Boston	2017-06-19	Goodenough J.	3	140	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
138	\N	2017-06-14	Goodenough J.	3	450	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
142	Chicago	2017-06-10	Goodenough J.	3	120	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
148	\N	2017-06-04	Goodenough J.	3	340	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
153	Boston	2017-05-30	Goodenough J.	3	250	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
158	\N	2017-05-25	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
164	\N	2017-05-19	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
169	\N	2017-05-14	Goodenough J.	3	30	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
174	\N	2017-05-09	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
179	Chicago	2017-05-04	Goodenough J.	3	340	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
184	\N	2017-04-29	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
190	\N	2017-04-23	Goodenough J.	3	420	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
195	Chicago	2017-04-18	Goodenough J.	3	350	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
200	\N	2017-04-13	Goodenough J.	3	330	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
205	\N	2017-07-23	\N	\N	300	\N	\N	\N	\N	\N	2017-07-23 20:42:46.356+03	2017-07-23 20:42:46.356+03	2	6	\N	\N	\N	\N
208	\N	2017-07-26	\N	\N	240	\N	\N	\N	\N	\N	2017-07-27 20:51:54.664+03	2017-07-27 20:55:46.131+03	4	6	\N	\N	\N	\N
215	Tallahassee	2017-07-30	MJE	200	60	\N	\N	\N	\N	\N	2017-07-30 18:03:58.225+03	2017-07-30 18:03:58.225+03	4	2	\N	\N	\N	\N
78	\N	2017-05-05	Goodenough J.	3	280	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
83	\N	2017-04-30	Goodenough J.	3	320	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
88	\N	2017-04-25	Goodenough J.	3	30	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	7	\N	\N	\N	\N
92	\N	2017-04-21	Goodenough J.	3	270	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
97	\N	2017-04-16	Goodenough J.	3	230	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	4	\N	\N	\N	\N
102	\N	2017-07-20	Goodenough J.	3	310	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
107	\N	2017-07-15	Goodenough J.	3	440	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
112	\N	2017-07-10	Goodenough J.	3	50	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
117	Chicago	2017-07-05	Goodenough J.	3	420	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
122	Chicago	2017-06-30	Goodenough J.	3	150	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
127	\N	2017-06-25	Goodenough J.	3	210	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
132	\N	2017-06-20	Goodenough J.	3	440	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
137	\N	2017-06-15	Goodenough J.	3	110	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
143	\N	2017-06-09	Goodenough J.	3	180	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
147	\N	2017-06-05	Goodenough J.	3	350	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
152	\N	2017-05-31	Goodenough J.	3	440	some notes	\N	\N	te-lc-admin	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
157	\N	2017-05-26	Goodenough J.	3	240	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
163	\N	2017-05-20	Goodenough J.	3	480	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
167	\N	2017-05-16	Goodenough J.	3	390	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
172	Boston	2017-05-11	Goodenough J.	3	400	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
177	\N	2017-05-06	Goodenough J.	3	20	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
182	\N	2017-05-01	Goodenough J.	3	140	some notes	\N	\N	te-lc-comp	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
188	\N	2017-04-25	Goodenough J.	3	20	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
193	\N	2017-04-20	Goodenough J.	3	460	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
198	\N	2017-04-15	Goodenough J.	3	110	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	8	\N	\N	\N	\N
202	\N	2017-07-22	rrt	\N	120	blah	\N	\N	\N	\N	2017-07-23 18:23:27.842+03	2017-07-23 18:23:27.842+03	2	7	\N	\N	\N	\N
210	Panama City	2017-07-27	MCH	130	240	\N	\N	\N	\N	te-pc-judges	2017-07-27 20:52:51.228+03	2017-07-27 20:54:54+03	4	2	\N	\N	\N	\N
212	\N	2017-07-21	\N	\N	180	\N	\N	\N	\N	\N	2017-07-27 20:56:47.217+03	2017-07-27 20:56:47.217+03	4	4	\N	\N	\N	\N
79	\N	2017-05-04	Goodenough J.	3	120	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	8	\N	\N	\N	\N
84	\N	2017-04-29	Goodenough J.	3	230	some notes	\N	\N	te-lc-annual	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
90	\N	2017-04-23	Goodenough J.	3	140	some notes	\N	\N	te-lc-sick	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	1	\N	\N	\N	\N
95	Boston	2017-04-18	Goodenough J.	3	160	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	3	\N	\N	\N	\N
99	\N	2017-04-14	Goodenough J.	3	160	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.603+03	2017-07-21 15:52:11.603+03	1	6	\N	\N	\N	\N
104	\N	2017-07-18	Goodenough J.	3	370	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
109	New York	2017-07-13	Goodenough J.	3	140	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
114	\N	2017-07-08	Goodenough J.	3	430	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
119	\N	2017-07-03	Goodenough J.	3	410	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
125	\N	2017-06-27	Goodenough J.	3	450	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
130	\N	2017-06-22	Goodenough J.	3	260	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
135	\N	2017-06-17	Goodenough J.	3	70	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
140	Boston	2017-06-12	Goodenough J.	3	200	some notes	\N	\N	\N	te-pc-magistrate	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
145	\N	2017-06-07	Goodenough J.	3	80	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
150	\N	2017-06-02	Goodenough J.	3	180	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
155	\N	2017-05-28	Goodenough J.	3	120	some notes	\N	\N	te-lc-admin	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	1	\N	\N	\N	\N
160	\N	2017-05-23	Goodenough J.	3	220	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
165	New York	2017-05-18	Goodenough J.	3	340	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	2	\N	\N	\N	\N
170	\N	2017-05-13	Goodenough J.	3	40	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
175	\N	2017-05-08	Goodenough J.	3	200	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	7	\N	\N	\N	\N
180	Boston	2017-05-03	Goodenough J.	3	100	some notes	\N	\N	\N	te-pc-other	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	3	\N	\N	\N	\N
185	\N	2017-04-28	Goodenough J.	3	370	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	6	\N	\N	\N	\N
189	\N	2017-04-24	Goodenough J.	3	90	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
194	\N	2017-04-19	Goodenough J.	3	160	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	5	\N	\N	\N	\N
199	\N	2017-04-14	Goodenough J.	3	420	some notes	\N	\N	\N	\N	2017-07-21 15:52:11.69+03	2017-07-21 15:52:11.69+03	2	4	\N	\N	\N	\N
204	\N	2017-07-23	\N	\N	180	\N	\N	\N	\N	\N	2017-07-23 20:16:46.059+03	2017-07-23 20:16:46.059+03	2	8	\N	\N	\N	\N
207	Tallahassee	2017-07-26	MMS	120	24030	\N	\N	\N	\N	te-pc-judges	2017-07-27 20:51:39.435+03	2017-07-27 20:55:27.334+03	4	2	\N	\N	\N	\N
214	\N	2017-07-20	MMS	67	120	\N	\N	\N	\N	\N	2017-07-27 20:57:36.06+03	2017-07-27 20:57:36.06+03	4	2	\N	\N	\N	\N
1	sdffsad	2017-07-21	Goodenough J.	3	420	some notes	\N	\N	\N	te-pc-judges	2017-07-21 15:52:11.603+03	2017-09-21 19:40:36.59+03	1	23	\N	\N	\N	\N
216	xxxx	2017-09-21	\N	\N	0	\N	\N	\N	\N	\N	2017-09-21 19:42:10.022+03	2017-09-21 19:42:10.022+03	1	18	\N	\N	\N	\N
217	New York	2017-09-21	\N	\N	0	\N	\N	\N	\N	\N	2017-09-21 19:42:49.653+03	2017-09-21 19:42:49.653+03	2	3	\N	\N	\N	\N
218	\N	2017-09-21	\N	\N	0	\N	\N	\N	\N	te-pc-judges	2017-09-21 22:37:17.656+03	2017-09-21 22:37:17.656+03	2	2	\N	\N	\N	\N
\.


--
-- Name: TimeEntries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"TimeEntries_id_seq"', 218, true);


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: dmitru
--

COPY "Users" (id, "accountType", "firstName", "lastName", suffix, email, password, "passwordResetToken", "passwordResetTokenExpires", "stripeCustomerId", "stripeSubscriptionId", "stripeUserId", "stripeUserRefreshToken", "signupCompleted", "googleAccountEmail", "federalEmployeeId", "federalOfficialDutyStation", district, county, "branchNumber", "einNumber", "socialSecurityNumber", "companyName", "companyWebsite", address, "addressCont", city, state, zip, phone, fax, "additionalPaymentTerms", "avatarUrl", "avatarBucket", "avatarKey", "profileCertifications", "profileWelcomeMessage", "profileShowContactInfo", "profileShowContactForm", "profileShowTranscriptRequestForm", "ratesCivilPrivateOrdinaryOriginal", "ratesCivilPrivateOrdinary1stCopy", "ratesCivilPrivateOrdinary2ndCopy", "ratesCivilPrivate14DayOriginal", "ratesCivilPrivate14Day1stCopy", "ratesCivilPrivate14Day2ndCopy", "ratesCivilPrivateExpeditedOriginal", "ratesCivilPrivateExpedited1stCopy", "ratesCivilPrivateExpedited2ndCopy", "ratesCivilPrivateDailyOriginal", "ratesCivilPrivateDaily1stCopy", "ratesCivilPrivateDaily2ndCopy", "ratesCivilPrivateHourlyOriginal", "ratesCivilPrivateHourly1stCopy", "ratesCivilPrivateHourly2ndCopy", "ratesCivilPrivateRealtimeOriginal", "ratesCivilPrivateRealtime1stCopy", "ratesCivilPrivateRealtime2ndCopy", "ratesCivilOfficialOrdinaryOriginal", "ratesCivilOfficialOrdinary1stCopy", "ratesCivilOfficialOrdinary2ndCopy", "ratesCivilOfficial14DayOriginal", "ratesCivilOfficial14Day1stCopy", "ratesCivilOfficial14Day2ndCopy", "ratesCivilOfficialExpeditedOriginal", "ratesCivilOfficialExpedited1stCopy", "ratesCivilOfficialExpedited2ndCopy", "ratesCivilOfficialDailyOriginal", "ratesCivilOfficialDaily1stCopy", "ratesCivilOfficialDaily2ndCopy", "ratesCivilOfficialHourlyOriginal", "ratesCivilOfficialHourly1stCopy", "ratesCivilOfficialHourly2ndCopy", "ratesCivilOfficialRealtimeOriginal", "ratesCivilOfficialRealtime1stCopy", "ratesCivilOfficialRealtime2ndCopy", "ratesCriminalPrivateOrdinaryOriginal", "ratesCriminalPrivateOrdinary1stCopy", "ratesCriminalPrivateOrdinary2ndCopy", "ratesCriminalPrivate14DayOriginal", "ratesCriminalPrivate14Day1stCopy", "ratesCriminalPrivate14Day2ndCopy", "ratesCriminalPrivateExpeditedOriginal", "ratesCriminalPrivateExpedited1stCopy", "ratesCriminalPrivateExpedited2ndCopy", "ratesCriminalPrivateDailyOriginal", "ratesCriminalPrivateDaily1stCopy", "ratesCriminalPrivateDaily2ndCopy", "ratesCriminalPrivateHourlyOriginal", "ratesCriminalPrivateHourly1stCopy", "ratesCriminalPrivateHourly2ndCopy", "ratesCriminalPrivateRealtimeOriginal", "ratesCriminalPrivateRealtime1stCopy", "ratesCriminalPrivateRealtime2ndCopy", "ratesCriminalOfficialOrdinaryOriginal", "ratesCriminalOfficialOrdinary1stCopy", "ratesCriminalOfficialOrdinary2ndCopy", "ratesCriminalOfficial14DayOriginal", "ratesCriminalOfficial14Day1stCopy", "ratesCriminalOfficial14Day2ndCopy", "ratesCriminalOfficialExpeditedOriginal", "ratesCriminalOfficialExpedited1stCopy", "ratesCriminalOfficialExpedited2ndCopy", "ratesCriminalOfficialDailyOriginal", "ratesCriminalOfficialDaily1stCopy", "ratesCriminalOfficialDaily2ndCopy", "ratesCriminalOfficialHourlyOriginal", "ratesCriminalOfficialHourly1stCopy", "ratesCriminalOfficialHourly2ndCopy", "ratesCriminalOfficialRealtimeOriginal", "ratesCriminalOfficialRealtime1stCopy", "ratesCriminalOfficialRealtime2ndCopy", "createdAt", "updatedAt", "middleName", prefix, "ratesPagesProofreading", "ratesPagesProofreadingRush", "ratesPagesProofreadingDaily", "ratesPagesScoping", "ratesPagesScopingRush", "ratesPagesScopingDaily", "ratesHoursProofreading", "ratesHoursProofreadingRush", "ratesHoursProofreadingDaily", "ratesHoursScoping", "ratesHoursScopingRush", "ratesHoursScopingDaily", "lastSeenNotificationId", "ratesPagesStateExpedited", "ratesPagesStateStandard", "ratesPagesStateDaily", "ratesPagesStateRealtime", "ratesPagesStateRoughCopy", "ratesPagesStateCopy", "isAdmin", "taxRate", "billingPeriod", "subscriptionPlan", "federalInvoiceTitle", "notificationsInvoicePaymentReceived", "notificationsIncomingInvoice") FROM stdin;
4	account-type-federal	Judy A.	Gagnon	\N	judy.gagnon.federal@reportersuite.com	$2a$10$5fw73dlqz7iwAeRQ7QItK.zT74rh3.GGGEyntnqCy1DDDMr7ABY9K	\N	\N	\N	sub_B5fHk3E0d3mr2C	acct_1Am019HnNiTdLjj9	sk_test_oa32cLjCQTBoWXmiqdkh5m1z	t	\N	123456	Tallahassee	Northern District of Florida	\N	\N	27-5099576	\N	United States District Court	\N	111 North Adams Street	\N	Tallahassee	Florida	32301	(850) 561-6822	\N	Additional Information\n\nFull price may be charged only if the transcript is delivered within the required time frame. For example, if an order for expedited transcript is not completed and delivered within (7) calendar days, payment would be at the 14-day delivery rate, and if not completed and delivered within 14 days, payment would be at the ordinary delivery rate.\nI certify that the transcript fees charged and page format used comply with the requirements of this court and the Judicial Conference of the United States.	https://reportersuite-dev.s3.us-east-2.amazonaws.com/user-avatars%2Fuser-avatar-4-e72361cf-17b9-474c-9146-c329569b77e2	reportersuite-dev	user-avatars/user-avatar-4-e72361cf-17b9-474c-9146-c329569b77e2	{"RMR, FCRR"}	\N	t	t	t	365	90	60	425	90	60	485	90	60	605	120	90	725	120	90	305	150	120	365	90	60	425	90	60	485	90	60	605	120	90	725	120	90	305	150	120	325	90	60	425	90	60	485	90	60	605	120	90	725	120	90	305	150	120	325	90	60	425	90	60	485	90	60	605	120	90	725	120	90	305	150	120	2017-07-25 17:24:11.378+03	2017-08-03 15:28:02.495+03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	Official US Court Reporter	t	t
3	account-type-standard	Judy A.	Gagnon	\N	judy.gagnon@reportersuite.com	$2a$10$CFtckgUKfrNG6P8coFSrI.43NP0P87zUW04a2477PYUix.EpAG7me	\N	\N	\N	sub_B5fGSjlcdv2BuF	\N	\N	t	\N	\N	\N	Northern District of Florida, Tallahassee Division	\N	\N	27-5099576	\N	United States District Court	\N	111 North Adams Street	\N	Tallahassee	Florida	32301	(850) 561-6822	\N	Full price may be charged only if the transcript is delivered within the required time frame.   For example, if an order for expedited transcript is not completed and delivered within (7) calendar days, payment would be at the 14-day delivery rate, and if not completed and delivered within 14 days, payment would be at this ordinary delivery rate.\n\nI certify that the transcript fees charged and page format used comply with the requirements of this court and the Judicial Conference of the United States.	\N	\N	\N	{"RMR, FCRR"}	\N	t	t	t	365	90	60	425	90	60	485	90	60	605	120	90	725	120	90	350	120	150	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	365	90	60	425	90	60	485	90	60	605	120	90	485	120	90	305	120	150	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2017-07-25 17:23:19.318+03	2017-07-27 18:46:05.004+03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	Official US Court Reporter	t	t
7	account-type-standard	Dmitry	Borody	\N	dmitriy.borodiy@gmail.com	\N	\N	\N	cus_BOjxwC9RUqTjW9	sub_BOjxu5hNEWky5a	\N	\N	t	dmitriy.borodiy@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-14 15:23:16.158+03	2017-09-14 15:30:16.122+03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	f	\N	yearly	V3_Yearly	Official US Court Reporter	t	t
8	account-type-standard	sdf	sdf	\N	sdf@df.com	$2a$10$G3Buy/MmqzSQ8IxKMxdrJeqZug1D0VL36/QTpEACMvWbYoi07vo52	\N	\N	cus_BOpqmiwSW3kI58	sub_BOpqXIQdMJMlUQ	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-09-14 21:35:00.082+03	2017-09-14 21:35:00.082+03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	f	\N	yearly	V3_Yearly	Official US Court Reporter	t	t
1	account-type-standard	User2	Tester	\N	user@test.com	$2a$10$.F1peYjyGKNgfpJsWEoCce3nxcYso8znshUE6AgPEI9ztXLMOAriW	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{sdf,sdfsdfsd}	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2017-07-21 15:52:11.49+03	2017-09-20 00:28:26.262+03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	f	30000	\N	\N	Official US Court Reporter	t	t
2	account-type-federal	User2	Tester	\N	user2@test.com	$2a$10$.F1peYjyGKNgfpJsWEoCce3nxcYso8znshUE6AgPEI9ztXLMOAriW	\N	\N	\N	\N	acct_1AaNkgIYX5GAvZPw	sk_test_RIFRzOeuNW0NBqzvRs70U8ed	t	\N	00044000	Tallahassee	Northern District of Florida	\N	\N	\N	\N	United States District Court	\N	111 North Adams Street	\N	Tallahassee	Florida	32301	850-561-6822	\N	\N	\N	\N	\N	\N	\N	t	t	t	365	90	60	425	90	60	485	90	60	605	120	90	720	120	90	305	120	120	365	90	60	425	90	60	485	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	2017-07-21 15:52:11.49+03	2017-09-22 16:07:31.699+03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	Official US Court Reporter	\N	t
\.


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmitru
--

SELECT pg_catalog.setval('"Users_id_seq"', 8, true);


--
-- Name: AttendanceCities AttendanceCities_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "AttendanceCities"
    ADD CONSTRAINT "AttendanceCities_pkey" PRIMARY KEY (id);


--
-- Name: CaseLogEntries CaseLogEntries_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "CaseLogEntries"
    ADD CONSTRAINT "CaseLogEntries_pkey" PRIMARY KEY (id);


--
-- Name: ConfigValues ConfigValues_key_key; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ConfigValues"
    ADD CONSTRAINT "ConfigValues_key_key" UNIQUE (key);


--
-- Name: ConfigValues ConfigValues_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ConfigValues"
    ADD CONSTRAINT "ConfigValues_pkey" PRIMARY KEY (id);


--
-- Name: Customers Customers_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Customers"
    ADD CONSTRAINT "Customers_pkey" PRIMARY KEY (id);


--
-- Name: ExpenseCategories ExpenseCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ExpenseCategories"
    ADD CONSTRAINT "ExpenseCategories_pkey" PRIMARY KEY (id);


--
-- Name: ExpenseEntries ExpenseEntries_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ExpenseEntries"
    ADD CONSTRAINT "ExpenseEntries_pkey" PRIMARY KEY (id);


--
-- Name: InvoiceItems InvoiceItems_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "InvoiceItems"
    ADD CONSTRAINT "InvoiceItems_pkey" PRIMARY KEY (id);


--
-- Name: InvoiceTemplateProofreadingAndScopings InvoiceTemplateProofreadingAndScopings_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "InvoiceTemplateProofreadingAndScopings"
    ADD CONSTRAINT "InvoiceTemplateProofreadingAndScopings_pkey" PRIMARY KEY (id);


--
-- Name: InvoiceTemplateStateAndFreelances InvoiceTemplateStateAndFreelances_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "InvoiceTemplateStateAndFreelances"
    ADD CONSTRAINT "InvoiceTemplateStateAndFreelances_pkey" PRIMARY KEY (id);


--
-- Name: Invoices Invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Invoices"
    ADD CONSTRAINT "Invoices_pkey" PRIMARY KEY (id);


--
-- Name: Notifications Notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Notifications_pkey" PRIMARY KEY (id);


--
-- Name: Payees Payees_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Payees"
    ADD CONSTRAINT "Payees_pkey" PRIMARY KEY (id);


--
-- Name: SentEmails SentEmails_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "SentEmails"
    ADD CONSTRAINT "SentEmails_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: TimeCategories TimeCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "TimeCategories"
    ADD CONSTRAINT "TimeCategories_pkey" PRIMARY KEY (id);


--
-- Name: TimeEntries TimeEntries_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "TimeEntries"
    ADD CONSTRAINT "TimeEntries_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: AttendanceCities AttendanceCities_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "AttendanceCities"
    ADD CONSTRAINT "AttendanceCities_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CaseLogEntries CaseLogEntries_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "CaseLogEntries"
    ADD CONSTRAINT "CaseLogEntries_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Customers Customers_firmId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Customers"
    ADD CONSTRAINT "Customers_firmId_fkey" FOREIGN KEY ("firmId") REFERENCES "Customers"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Customers Customers_reporterSuiteUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Customers"
    ADD CONSTRAINT "Customers_reporterSuiteUserId_fkey" FOREIGN KEY ("reporterSuiteUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Customers Customers_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Customers"
    ADD CONSTRAINT "Customers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ExpenseCategories ExpenseCategories_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ExpenseCategories"
    ADD CONSTRAINT "ExpenseCategories_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ExpenseEntries ExpenseEntries_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ExpenseEntries"
    ADD CONSTRAINT "ExpenseEntries_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "ExpenseCategories"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ExpenseEntries ExpenseEntries_payeeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ExpenseEntries"
    ADD CONSTRAINT "ExpenseEntries_payeeId_fkey" FOREIGN KEY ("payeeId") REFERENCES "Payees"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ExpenseEntries ExpenseEntries_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "ExpenseEntries"
    ADD CONSTRAINT "ExpenseEntries_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InvoiceItems InvoiceItems_invoiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "InvoiceItems"
    ADD CONSTRAINT "InvoiceItems_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoices"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InvoiceTemplateProofreadingAndScopings InvoiceTemplateProofreadingAndScopings_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "InvoiceTemplateProofreadingAndScopings"
    ADD CONSTRAINT "InvoiceTemplateProofreadingAndScopings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InvoiceTemplateStateAndFreelances InvoiceTemplateStateAndFreelances_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "InvoiceTemplateStateAndFreelances"
    ADD CONSTRAINT "InvoiceTemplateStateAndFreelances_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Invoices Invoices_customerFirmId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Invoices"
    ADD CONSTRAINT "Invoices_customerFirmId_fkey" FOREIGN KEY ("customerFirmId") REFERENCES "Customers"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Invoices Invoices_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Invoices"
    ADD CONSTRAINT "Invoices_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customers"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Invoices Invoices_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Invoices"
    ADD CONSTRAINT "Invoices_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Payees Payees_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "Payees"
    ADD CONSTRAINT "Payees_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SentEmails SentEmails_invoiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "SentEmails"
    ADD CONSTRAINT "SentEmails_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoices"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TimeCategories TimeCategories_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "TimeCategories"
    ADD CONSTRAINT "TimeCategories_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TimeEntries TimeEntries_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "TimeEntries"
    ADD CONSTRAINT "TimeEntries_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "TimeCategories"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TimeEntries TimeEntries_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmitru
--

ALTER TABLE ONLY "TimeEntries"
    ADD CONSTRAINT "TimeEntries_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO dmitru;


--
-- PostgreSQL database dump complete
--

