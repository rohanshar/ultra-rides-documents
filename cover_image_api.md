# Cover/Upload Image API

This document outlines how the front-end uploads or removes an event’s cover image. It describes the endpoint, request body, response format, and other details a backend developer will need to implement this functionality.

---

## Overview

The front-end currently allows authenticated users to edit the cover image of an event. To do so, it sends a **PATCH** request to:

PATCH /events/:eventId

The request body may contain a Base64-encoded image (to upload/update) or a directive to remove the cover image.

From the code perspective (for reference, in `EditEventCoverImage.js` and `EventCoverImageManager.js`), once a user selects or drops an image file:
1. The file is converted to Base64 using JavaScript’s `FileReader`.
2. We send a PATCH request containing the Base64 data to the endpoint.
3. The API should parse the Base64, store it (e.g., in S3 or local storage), and return the public URL of the newly stored image as `coverImageUrl`.

Alternatively, if the user chooses to remove the cover image, the front-end sends a PATCH with `coverImage: ''`.

---

## Endpoint Details

**Method**: `PATCH`
**URL**: `/events/:eventId`

Where `:eventId` is the unique identifier of an event. The user must be authorized to edit this event (i.e., must be the event’s owner or an admin).

### Request Headers

- `Authorization: Bearer <idToken>`
	- The front-end includes a valid authentication token to identify the user.

### Request Body

The request body is in JSON. It can contain one of the two possible payloads:

1. **Uploading/Updating an Image**

	```json
	{
		"imageBase64": "BASE64_ENCODED_IMAGE_DATA"
	}

What to do with imageBase64:
	•	This value is the Base64-encoded image string (excluding the data:image/...;base64, prefix).
	•	The backend should decode this string, validate the file size (the front-end tries to restrict to 5 MB or less), and store it in a permanent storage location (S3, local filesystem, or equivalent).
	•	Generate a public URL to this uploaded image (e.g., an S3 URL or a CDN link).
	•	Update the event’s record in the database to reference this new cover image URL (e.g., coverImage field in ultrarides_events table).

Constraints:
	•	Max file size: 5 MB
	•	Accepted formats: JPG, PNG, or WebP
	•	Recommended dimensions: 1920×1080 for best display
	•	The front-end automatically blocks larger files, but the backend should also confirm size to avoid accidental oversize uploads.

	2.	Removing an Existing Cover Image

{
	"coverImage": ""
}

What to do with coverImage: "":
	•	A blank string indicates the user wants to remove the cover image.
	•	The backend can set the coverImage field in the database to an empty string (or remove the attribute entirely).
	•	Optionally, the backend can also delete the physical file from storage (if desired), depending on the retention policy.

Note: The request can contain either "imageBase64" (upload) or "coverImage": "" (remove). The front-end uses these mutually exclusive strategies.

Example Requests

1. Uploading a Cover Image

PATCH /events/EVENT123
Authorization: Bearer eyJraWQiOi...<snip>...
Content-Type: application/json

{
	"imageBase64": "iVBORw0KGgoAAAANSUhEUgAAAK8AAACvCAYAAAB..."
}

Backend Handling:
	1.	Extract "imageBase64".
	2.	Decode and validate it.
	3.	Upload to storage, e.g., https://<bucket>.s3.amazonaws.com/events/EVENT123/cover.jpg.
	4.	Update DynamoDB (or your database) with coverImage = "the-public-url".
	5.	Return JSON with the updated coverImageUrl.

2. Removing a Cover Image

PATCH /events/EVENT123
Authorization: Bearer eyJraWQiOi...<snip>...
Content-Type: application/json

{
	"coverImage": ""
}

Backend Handling:
	1.	Interpret coverImage with an empty string as a remove signal.
	2.	Optionally delete the existing file from storage (if desired).
	3.	Update coverImage field in the database to "" (or remove it).
	4.	Return success response.

Response

On success, the backend should return HTTP 200 OK with a JSON body. The front-end relies on the returned coverImageUrl to update its state.

Example Success Response:

{
	"message": "Cover image updated successfully",
	"coverImageUrl": "https://cdn.example.com/events/EVENT123/cover.jpg"
}

Example Remove Response:

{
	"message": "Cover image removed"
}

Error Handling
	•	Return HTTP 400 Bad Request if:
	•	The imageBase64 is malformed or invalid.
	•	The image exceeds 5 MB or is of an unsupported format.
	•	Return HTTP 401 Unauthorized if the user is not authenticated or not authorized.
	•	Return HTTP 404 Not Found if :eventId does not exist or the user does not own that event.
	•	Return HTTP 500 Internal Server Error if storage or database operations fail unexpectedly.

Example Error Response:

{
	"message": "Failed to upload image",
	"error": "Invalid Base64 data"
}

Implementation Notes
	1.	Base64 Decoding: On the server, strip any prefix (data:image/...;base64,) if present, then decode to binary (e.g., using Node.js Buffer.from(imageBase64, 'base64') or a similar library in Python, Java, etc.).
	2.	Verification: Verify content type (like JPEG, PNG, WebP) either by:
	•	Checking the file signature after decoding (preferred).
	•	Or rely on the front-end restrictions (still less secure).
	3.	Storage:
	•	If using S3, generate a key pattern such as events/:eventId/cover.jpg.
	•	If using local disk, store it in a known directory and create a public URL.
	4.	DB Update:
	•	The ultrarides_events table includes a field coverImage (String). The server can set or clear it.
	•	If removing the image, the server might also want to delete or archive the old file.

Summary

To add or remove an event’s cover image:
	•	PATCH /events/:eventId with { "imageBase64": "<base64String>" } to upload.
	•	PATCH /events/:eventId with { "coverImage": "" } to remove.

Return updated event info (coverImageUrl) or an appropriate success message. Enforce authentication and ownership checks, as well as file size and format constraints.