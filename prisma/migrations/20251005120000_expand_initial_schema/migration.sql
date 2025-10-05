-- Migration: expand_initial_schema
-- Generated manually based on updated Prisma schema

-- Users table alterations
ALTER TABLE "User" ADD COLUMN "username" TEXT;
ALTER TABLE "User" ADD COLUMN "bio" TEXT;
ALTER TABLE "User" ADD COLUMN "avatarUrl" TEXT;
ALTER TABLE "User" ADD COLUMN "createdAt" TIMESTAMP DEFAULT NOW();
ALTER TABLE "User" ADD COLUMN "updatedAt" TIMESTAMP DEFAULT NOW();
ALTER TABLE "User" ADD CONSTRAINT user_username_unique UNIQUE ("username");
CREATE INDEX user_username_idx ON "User"("username");
CREATE INDEX user_email_idx ON "User"("email");

-- Follow table
CREATE TABLE "Follow" (
  "followerId" INTEGER NOT NULL,
  "followingId" INTEGER NOT NULL,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  CONSTRAINT "Follow_pkey" PRIMARY KEY ("followerId", "followingId"),
  CONSTRAINT "Follow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "Follow_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX "Follow_followingId_idx" ON "Follow"("followingId");

-- Author table
CREATE TABLE "Author" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "bio" TEXT
);
CREATE UNIQUE INDEX author_name_unique ON "Author"("name");
CREATE INDEX author_name_idx ON "Author"("name");

-- Book table
CREATE TABLE "Book" (
  "id" SERIAL PRIMARY KEY,
  "title" TEXT NOT NULL,
  "description" TEXT,
  "coverUrl" TEXT,
  "publishedYear" INTEGER,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "averageRating" DOUBLE PRECISION DEFAULT 0,
  "ratingsCount" INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX book_title_idx ON "Book"("title");

-- BookAuthor join table
CREATE TABLE "BookAuthor" (
  "bookId" INTEGER NOT NULL,
  "authorId" INTEGER NOT NULL,
  CONSTRAINT "BookAuthor_pkey" PRIMARY KEY ("bookId", "authorId"),
  CONSTRAINT "BookAuthor_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "BookAuthor_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX bookauthor_authorId_idx ON "BookAuthor"("authorId");

-- Review table
CREATE TABLE "Review" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "bookId" INTEGER NOT NULL,
  "rating" INTEGER NOT NULL,
  "title" TEXT,
  "content" TEXT NOT NULL,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  CONSTRAINT review_user_book_unique UNIQUE ("userId", "bookId"),
  CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "Review_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX review_bookId_idx ON "Review"("bookId");
CREATE INDEX review_userId_idx ON "Review"("userId");

-- Comment table
CREATE TABLE "Comment" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "reviewId" INTEGER NOT NULL,
  "content" TEXT NOT NULL,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  CONSTRAINT "Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "Comment_reviewId_fkey" FOREIGN KEY ("reviewId") REFERENCES "Review"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX comment_reviewId_idx ON "Comment"("reviewId");
CREATE INDEX comment_userId_idx ON "Comment"("userId");

-- ReadingList table
CREATE TABLE "ReadingList" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "isPublic" BOOLEAN NOT NULL DEFAULT FALSE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  CONSTRAINT readinglist_user_name_unique UNIQUE ("userId", "name"),
  CONSTRAINT "ReadingList_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX readinglist_userId_idx ON "ReadingList"("userId");
CREATE INDEX readinglist_isPublic_idx ON "ReadingList"("isPublic");

-- ReadingListBook join table
CREATE TABLE "ReadingListBook" (
  "readingListId" INTEGER NOT NULL,
  "bookId" INTEGER NOT NULL,
  "position" INTEGER,
  "addedAt" TIMESTAMP DEFAULT NOW(),
  CONSTRAINT "ReadingListBook_pkey" PRIMARY KEY ("readingListId", "bookId"),
  CONSTRAINT "ReadingListBook_readingListId_fkey" FOREIGN KEY ("readingListId") REFERENCES "ReadingList"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "ReadingListBook_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX readinglistbook_bookId_idx ON "ReadingListBook"("bookId");
