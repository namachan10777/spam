use std::collections::HashMap;

struct TagMap {
    pack_cnt: usize,
    pack_map: HashMap<String, usize>,
    versions: Vec<Vec<Semver>>,
}

#[derive(Debug, Clone, PartialEq)]
struct Semver {
    major: usize,
    minor: usize,
    patch: usize,
}

#[derive(Debug, Clone, PartialEq)]
enum Term {
    Not(u32),
    Yes(u32),
}

#[derive(Debug, Clone, PartialEq)]
enum R {
    Or(Term),
    And(Term),
}

#[derive(Debug, Clone, PartialEq)]
enum SemverParseErr {
    ParseErr,
}
impl Semver {
    fn new(str: &str) -> Result<Semver, SemverParseErr> {
        let splited: Vec<&str> = str.split('.').collect();
        if splited.len() != 3 {
            return Err(SemverParseErr::ParseErr)
        }
        let major = splited[0].parse();
        let minor = splited[1].parse();
        let patch = splited[2].parse();
        match (major, minor, patch) {
            (Ok(major), Ok(minor), Ok(patch)) =>
                Ok(Semver { major, minor, patch }),
            _ => Err(SemverParseErr::ParseErr)
        }
    }
}

#[cfg(test)]
mod semver_test {
    use super::*;
    #[test]
    fn test_semver_new() {
        assert_eq!(Semver::new("1.2.3"), Ok(Semver { major: 1, minor: 2, patch: 3 }));
        assert_eq!(Semver::new("0.0.0"), Ok(Semver { major: 0, minor: 0, patch: 0 }));
        assert_eq!(Semver::new("1.2"), Err(SemverParseErr::ParseErr));
        assert_eq!(Semver::new("1.2.x"), Err(SemverParseErr::ParseErr));
        assert_eq!(Semver::new("1.-2.3"), Err(SemverParseErr::ParseErr));
    }
}
