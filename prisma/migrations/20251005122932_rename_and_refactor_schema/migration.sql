/*
  Warnings:

  - You are about to drop the column `averageRating` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `coverUrl` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `publishedYear` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `ratingsCount` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `isPublic` on the `ReadingList` table. All the data in the column will be lost.
  - You are about to drop the `BookAuthor` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Follow` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ReadingListBook` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `createdAt` on table `Book` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `Book` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `Comment` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `Comment` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `ReadingList` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `ReadingList` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `Review` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `Review` required. This step will fail if there are existing NULL values in that column.
  - Made the column `username` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "public"."BookAuthor" DROP CONSTRAINT "BookAuthor_authorId_fkey";

-- DropForeignKey
ALTER TABLE "public"."BookAuthor" DROP CONSTRAINT "BookAuthor_bookId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Follow" DROP CONSTRAINT "Follow_followerId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Follow" DROP CONSTRAINT "Follow_followingId_fkey";

-- DropForeignKey
ALTER TABLE "public"."ReadingListBook" DROP CONSTRAINT "ReadingListBook_bookId_fkey";

-- DropForeignKey
ALTER TABLE "public"."ReadingListBook" DROP CONSTRAINT "ReadingListBook_readingListId_fkey";

-- DropIndex
DROP INDEX "public"."readinglist_ispublic_idx";

-- AlterTable
ALTER TABLE "Book" DROP COLUMN "averageRating",
DROP COLUMN "coverUrl",
DROP COLUMN "publishedYear",
DROP COLUMN "ratingsCount",
ADD COLUMN     "avgRating" DOUBLE PRECISION DEFAULT 0,
ADD COLUMN     "coverImageUrl" TEXT,
ADD COLUMN     "ratingCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "yearPublished" INTEGER,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT,
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Comment" ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT,
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMP(3);

-- AlterTable
ALTER TABLE "ReadingList" DROP COLUMN "isPublic",
ADD COLUMN     "public" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT,
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Review" ADD COLUMN     "helpfulCount" INTEGER NOT NULL DEFAULT 0,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT,
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMP(3);

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "username" SET NOT NULL,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT,
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMP(3);

-- DropTable
DROP TABLE "public"."BookAuthor";

-- DropTable
DROP TABLE "public"."Follow";

-- DropTable
DROP TABLE "public"."ReadingListBook";

-- CreateTable
CREATE TABLE "UserFollow" (
    "followerId" INTEGER NOT NULL,
    "followingId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserFollow_pkey" PRIMARY KEY ("followerId","followingId")
);

-- CreateTable
CREATE TABLE "AuthorOnBook" (
    "bookId" INTEGER NOT NULL,
    "authorId" INTEGER NOT NULL,

    CONSTRAINT "AuthorOnBook_pkey" PRIMARY KEY ("bookId","authorId")
);

-- CreateTable
CREATE TABLE "ReadingListItem" (
    "readingListId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,
    "order" INTEGER,
    "addedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ReadingListItem_pkey" PRIMARY KEY ("readingListId","bookId")
);

-- CreateIndex
CREATE INDEX "UserFollow_followingId_idx" ON "UserFollow"("followingId");

-- CreateIndex
CREATE INDEX "AuthorOnBook_authorId_idx" ON "AuthorOnBook"("authorId");

-- CreateIndex
CREATE INDEX "ReadingListItem_bookId_idx" ON "ReadingListItem"("bookId");

-- CreateIndex
CREATE INDEX "ReadingList_public_idx" ON "ReadingList"("public");

-- AddForeignKey
ALTER TABLE "UserFollow" ADD CONSTRAINT "UserFollow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFollow" ADD CONSTRAINT "UserFollow_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuthorOnBook" ADD CONSTRAINT "AuthorOnBook_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuthorOnBook" ADD CONSTRAINT "AuthorOnBook_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReadingListItem" ADD CONSTRAINT "ReadingListItem_readingListId_fkey" FOREIGN KEY ("readingListId") REFERENCES "ReadingList"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReadingListItem" ADD CONSTRAINT "ReadingListItem_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- RenameIndex
ALTER INDEX "author_name_idx" RENAME TO "Author_name_idx";

-- RenameIndex
ALTER INDEX "author_name_unique" RENAME TO "Author_name_key";

-- RenameIndex
ALTER INDEX "book_title_idx" RENAME TO "Book_title_idx";

-- RenameIndex
ALTER INDEX "comment_reviewid_idx" RENAME TO "Comment_reviewId_idx";

-- RenameIndex
ALTER INDEX "comment_userid_idx" RENAME TO "Comment_userId_idx";

-- RenameIndex
ALTER INDEX "readinglist_user_name_unique" RENAME TO "ReadingList_userId_name_key";

-- RenameIndex
ALTER INDEX "readinglist_userid_idx" RENAME TO "ReadingList_userId_idx";

-- RenameIndex
ALTER INDEX "review_bookid_idx" RENAME TO "Review_bookId_idx";

-- RenameIndex
ALTER INDEX "review_user_book_unique" RENAME TO "Review_userId_bookId_key";

-- RenameIndex
ALTER INDEX "review_userid_idx" RENAME TO "Review_userId_idx";

-- RenameIndex
ALTER INDEX "user_email_idx" RENAME TO "User_email_idx";

-- RenameIndex
ALTER INDEX "user_username_idx" RENAME TO "User_username_idx";

-- RenameIndex
ALTER INDEX "user_username_unique" RENAME TO "User_username_key";
