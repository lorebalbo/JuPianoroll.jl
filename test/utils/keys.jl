using Test

@testset "notes_in_scale tests" begin
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major)) == [0, 2, 4, 5, 7, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major)) == [0, 1, 3, 5, 6, 8, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major)) == [1, 2, 4, 6, 7, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major)) == [0, 2, 3, 5, 7, 8, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major)) == [1, 3, 4, 6, 8, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major)) == [0, 2, 4, 5, 7, 9, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == [1, 3, 5, 6, 8, 10, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == [0, 2, 4, 6, 7, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == [0, 1, 3, 5, 7, 8, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == [1, 2, 4, 6, 8, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == [0, 2, 3, 5, 7, 9, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == [1, 3, 4, 6, 8, 10, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == [0, 2, 3, 5, 7, 8, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == [1, 3, 4, 6, 8, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == [0, 2, 4, 5, 7, 9, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == [1, 3, 5, 6, 8, 10, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == [0, 2, 4, 6, 7, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == [0, 1, 3, 5, 7, 8, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == [1, 2, 4, 6, 8, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == [0, 2, 3, 5, 7, 9, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == [1, 3, 4, 6, 8, 10, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == [0, 2, 4, 5, 7, 9, 11]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == [0, 1, 3, 5, 6, 8, 10]
    @test JuPianoroll._notes_in_scale(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == [1, 2, 4, 6, 7, 9, 11]
end

@testset "key_distance tests" begin
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 0
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Major), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.C, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Cs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -2
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 6
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.D, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.Ds, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -4
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.E, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -5
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.F, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == -6
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Fs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 5
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.G, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 4
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.Gs, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 3
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor)) == 1
    @test key_distance(JuPianoroll.Key(JuPianoroll.A, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 2
    @test key_distance(JuPianoroll.Key(JuPianoroll.As, JuPianoroll.Minor), JuPianoroll.Key(JuPianoroll.B, JuPianoroll.Minor)) == 1
end
