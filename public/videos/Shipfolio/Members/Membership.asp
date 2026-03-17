<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> </title>
<meta name="Title" content="Create Account - <%=WebSiteName %> ">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="<%=WebSiteName %>">
<link rel="stylesheet" type="text/css" href="/includefiles/Style.css">
</head>
<body >
<!--#Include virtual="/Header.asp"-->


<style>
    body {
        font-family: sans-serif;
        background-color: #f3f4f6; /* bg-gray-100 */
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    .container {
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        padding-left: 1rem; /* px-4 */
        padding-right: 1rem; /* px-4 */
        max-width: 72rem;
    }
    .mx-auto {
        margin-left: auto;
        margin-right: auto;
    }
    .mt-8 {
        margin-top: 2rem; /* mt-8 */
    }
    .p-6 {
        padding: 1.5rem; /* p-6 */
    }
    .bg-white {
        background-color: #fff;
    }
    .shadow-lg {
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }
    .rounded-lg {
        border-radius: 0.5rem;
    }
    .text-3xl {
        font-size: 1.875rem; /* text-3xl */
        line-height: 2.25rem; /* leading-9 */
    }
    .text-2xl {
        font-size: 1.5rem; /* text-2xl */
        line-height: 2rem;
    }
    .font-bold {
        font-weight: 700;
    }
    .text-center {
        text-align: center;
    }
    .text-gray-800 {
        color: #1f2937; /* text-gray-800 */
    }
    .mb-4 {
        margin-bottom: 1rem; /* mb-4 */
    }
    .mb-6 {
        margin-bottom: 1.5rem; /* mb-6 */
    }
    .block {
        display: block;
    }
    .text-gray-700 {
        color: #374151; /* text-gray-700 */
    }
    .text-sm {
        font-size: 0.875rem; /* text-sm */
        line-height: 1.25rem; /* leading-5 */
    }
    .shadow {
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    }
    .appearance-none {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
    }
    .border {
        border-width: 1px;
        border-style: solid;
        border-color: #d1d5db; /* border-gray-300 */
    }
    .rounded {
        border-radius: 0.25rem;
    }
    .w-full {
        width: 100%;
    }
    .py-2 {
        padding-top: 0.5rem; /* py-2 */
        padding-bottom: 0.5rem; /* py-2 */
    }
    .px-3 {
        padding-left: 0.75rem; /* px-3 */
        padding-right: 0.75rem; /* px-3 */
    }
    .leading-tight {
        line-height: 1.25;
    }
    .focus\:outline-none:focus {
        outline: 2px solid transparent;
        outline-offset: 2px;
    }
    .focus\:shadow-outline:focus {
        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5); /* blue-500 equivalent focus ring */
    }
    .text-gray-500 {
        color: #6b7280; /* text-gray-500 */
    }
    .text-red-700 {
        color: #b91c1c; /* text-red-700 */
    }
    .text-red-500 {
        color: #ef4444; /* text-red-500 */
    }
    .text-xs {
        font-size: 0.75rem; /* text-xs */
        line-height: 1rem; /* leading-4 */
    }
    .italic {
        font-style: italic;
    }
    .mt-1 {
        margin-top: 0.25rem; /* mt-1 */
    }
    .hidden {
        display: none;
    }
    .pr-10 {
        padding-right: 2.5rem; /* pr-10 */
    }
    .flex {
        display: flex;
    }
    .items-center {
        align-items: center;
    }
    .items-start {
        align-items: flex-start;
    }
    .mb-2 {
        margin-bottom: 0.5rem; /* mb-2 */
    }
    .justify-end {
        justify-content: flex-end;
    }
    .bg-blue-500 {
        background-color: #3b82f6; /* bg-blue-500 */
    }
    .hover\:bg-blue-700:hover {
        background-color: #1d4ed8; /* hover:bg-blue-700 */
    }
    .text-white {
        color: #fff;
    }
    .px-4 {
        padding-left: 1rem; /* px-4 */
        padding-right: 1rem; /* px-4 */
    }
    .space-y-2 > *:not([hidden]) ~ *:not([hidden]) {
        margin-top: 0.5rem; /* For list item spacing */
    }
    .text-green-500 {
        color: #22c55e; /* Tailwind green-500 */
    }
    .mr-2 {
        margin-right: 0.5rem;
    }
    .flex-shrink-0 {
        flex-shrink: 0;
    }
    .mt-4 {
        margin-top: 1rem;
    }
    .w-4 {
        width: 1rem;
    }
    .h-4 {
        height: 1rem;
    }
    /* --- The multi-column styles below are no longer used by this page, --- */
    /* --- but are kept in case other pages on your site need them. --- */
    .layout-grid {
        display: flex;
        flex-wrap: wrap; 
        gap: 1.5rem; 
    }
    .info-column, .form-column {
        width: 100%;
    }
    .spacer-column {
        display: none;
    }
    @media (min-width: 768px) {
        .layout-grid {
            flex-wrap: nowrap;
        }
        .spacer-column {
            display: block; 
            width: 20%; 
        }
        .info-column {
            width: 40%;
            margin-bottom: 0;
        }
        .form-column {
            width: 40%;
        }
    }
</style>


<div class="container mx-auto mt-8">
    <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Your Membership</h1>

    <div class="p-6 bg-white shadow-lg rounded-lg mb-6">
        <h2 class="text-2xl font-bold text-gray-800 mb-4 text-center">Basic Membership Includes:</h2>
        <ul class="text-gray-700 space-y-2">
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>Ag Advice:</strong> Boost your farm's success with Charlie's AI-powered insights for weather, soil, pests, and livestock.
                </div>
            </li>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>Standard Business Listing:</strong> Display your farm or business name, contact information, and a concise description on our directory.
                </div>
            </li>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>Multiple Organizational Listings.:</strong> List all of your business and Organizations (farms, restaurants, etc.)
                </div>
            </li>
        </ul>
        <br><br>
        <h3>Coming Soon!</h3>
        <ul>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>5 Livestock Listings:</strong> Includes photos, awards, progeny, ancestry, description, and more.
                </div>
            </li>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>5 Produce Listings:</strong> Includes photos, price, harvest date, description, and more.
                </div>
            </li>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>Community Forum Access:</strong> Engage with other members, share insights, and ask questions in our exclusive online forums.
                </div>
            </li>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>Limited Photo Gallery:</strong> Showcase up to 5 high-quality images of your animals, products, or facilities.
                </div>
            </li>
            <li class="flex items-start">
                <svg class="w-4 h-4 text-green-500 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                <div>
                    <strong>Event Calendar Access:</strong> View upcoming industry events and submit your own public events to our community calendar.
                </div>
            </li>
        </ul>
    </div>
</div>



<br>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>