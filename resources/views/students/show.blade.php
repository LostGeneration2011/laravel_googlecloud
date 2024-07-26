<!-- resources/views/students/show.blade.php -->

@extends('layout')

@section('content')
<div class="container mt-5">
    <h2>Student Details</h2>
    
    <div class="card">
        <div class="card-header">
            Details of {{ $student->name }}
        </div>
        <div class="card-body">
            <p><strong>ID:</strong> {{ $student->id }}</p>
            <p><strong>Name:</strong> {{ $student->name }}</p>
            <p><strong>Email:</strong> {{ $student->email }}</p>
            <p><strong>Age:</strong> {{ $student->age }}</p>
            <a href="{{ route('students.index') }}" class="btn btn-primary">Back to List</a>
            <a href="{{ route('students.edit', $student->id) }}" class="btn btn-warning">Edit</a>
            <form action="{{ route('students.destroy', $student->id) }}" method="POST" style="display:inline-block;">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </div>
    </div>
</div>
@endsection
