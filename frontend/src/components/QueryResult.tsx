'use client';
import { Box, VStack, Text, Heading } from '@chakra-ui/react';
import ResultsTable from './ResultsTable';

interface QueryResultProps {
  question: string;
  sql: string;
  results: Array<Record<string, string | number>>;
}

export default function QueryResult({ question, sql, results }: QueryResultProps) {
  return (
    <VStack spacing={6} align="stretch" p={{ base: 4, md: 8 }}>
      <Box bg="gray.50" p={4} rounded="lg" shadow="sm">
        <Heading as="h3" size="md" mb={2}>Your Question</Heading>
        <Text>{question}</Text>
      </Box>
      <Box bg="gray.50" p={4} rounded="lg" shadow="sm">
        <Heading as="h3" size="md" mb={2}>Generated SQL</Heading>
        <Text fontFamily="mono" fontSize="sm">{sql}</Text>
      </Box>
      <ResultsTable data={results} />
    </VStack>
  );
}
